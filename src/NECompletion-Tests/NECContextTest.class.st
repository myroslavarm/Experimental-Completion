Class {
	#name : #NECContextTest,
	#superclass : #TestCase,
	#category : #'NECompletion-Tests'
}

{ #category : #private }
NECContextTest >> checkUntypedVariablesOnly: aString [
	| context model |
	context := self createContextFor: aString at: aString size.
	self assert: context isVariablesOnly.
	model := context model.
	model loadEntries.
	self assert: model hasMessage not.
	self denyEmpty: (model entriesOfType: #instVar).
	context narrowWith: 'a'.
	self assertEmpty: (model entriesOfType: #selector)
]

{ #category : #private }
NECContextTest >> createContextFor: aString at: anInteger [ 
	^ NECContext
		controller: NECController new
		class: NECTestClass
		source: aString
		position: anInteger
]

{ #category : #tests }
NECContextTest >> testCompletionToken [
	| text context |
	text := 'testIt: aRectangle
	| abc |
	test.
	abc daf'.
	context := self createContextFor: text at: text size.
	self assert: context completionToken = 'daf'
]

{ #category : #tests }
NECContextTest >> testCompletionTokenEmpty [
	| text context |
	text := 'testIt: aRectangle
	| abc |
	test.
	abc daf '.
	context := self createContextFor: text at: text size.
	self assert: context completionToken equals: ''
]

{ #category : #tests }
NECContextTest >> testCreateModel [
	| text context model |
	text := 'testIt: aRectangle
	aRectangle printS'.
	context := self createContextFor: text at: text size.
	model := context model.
	self assert: model class equals: NECTypedModel.
	
	text := 'testIt:'.
	context := self createContextFor: text at: text size.
	model := context model.
	self assert: model class equals: NECUntypedModel.
	
	text := 'testIt: rect
	rect is'.
	context := self createContextFor: text at: text size.
	model := context model.
	self assert: model class equals: NECUntypedModel
]

{ #category : #tests }
NECContextTest >> testEmpty [
	self createContextFor: '' at: 0
]

{ #category : #tests }
NECContextTest >> testInTheMiddelOfAWord [
	| text context |
	text := 'hagada'.
	context := self 
		createContextFor: text
		at: 4.
	self assert: context completionToken = 'haga'
]

{ #category : #tests }
NECContextTest >> testReceiverArgument [
	| text context model |
	text := 'testIt: aRectangle
	aRectangle printS'.
	context := self 
		createContextFor: text
		at: text size.
	self assert: context receiverClass == Rectangle.
	model := context model.
	self assert: ((model entries collect: #contents) includes: #printString).
	
	text := 'testIt: rect
	rect is'.
	context := self 
		createContextFor: text
		at: text size.
	model := context model.
	self assert: model class equals: NECUntypedModel
]

{ #category : #tests }
NECContextTest >> testReceiverCascade [
	| text context model |
	text := 'testIt
	| b |
	b := Stream new.
	b 
		nextPutAll: ''test''; 
		nextPut: $c;
		st'.
	context := self createContextFor: text at: text size.
	self assert: context receiverClass == Stream.
	text := 'testIt
	| b |
	b := Stream new
		nextPutAll: ''test''; 
		nextPut: $c with: true;
		s'.
	context := self createContextFor: text at: text size.
	self assert: context receiverClass == Stream.
	text := 'testIt: aStream
	| test |
	aStream
		nextPutAll: ''test''; 
		nextPut: $c with: true;
		s'.
	context := self createContextFor: text at: text size.
	self assert: context receiverClass == Stream.
	model := context model.
	self assert: ((model entries collect: #contents) includes: #stepTime).
	
	text := 'testIt: aStream
	aStream
		nextPutAll: ''test''; 
		nextPut: $c with: true;
		s'.
	context := self createContextFor: text at: text size.
	self assert: context receiverClass == Stream.
	model := context model.
	self assert: ((model entries collect: #contents) includes: #stepTime).
]

{ #category : #tests }
NECContextTest >> testReceiverClassVar [
	| text context model |
	text := 'testIt
	ClassAnnotation so'.
	context := self 
		createContextFor: text
		at: text size.
	model := context model.
	self assert: model class equals: NECTypedModel
]

{ #category : #tests }
NECContextTest >> testReceiverConstant [
	| text context model |
	text := 'testIt
	15r16 as'.
	context := self createContextFor: text at: text size.
	model := context model.
	self assert: ((model entries collect: #contents) includes: #as31BitSmallInt).
	
	text := 'testIt
	''test'' pre'.
	context := self createContextFor: text at: text size.
	model := context model.
	self assert: ((model entries collect: #contents) includes: #prefixMatchesRegex:).
	
	text := 'testIt
	true ifTr'.
	context := self createContextFor: text at: text size.
	model := context model.
	self assert: ((model entries collect: #contents) includes: #ifTrue:ifFalse:).
	
	text := 'testIt
	false  "this is it"
		xo'.
	context := self createContextFor: text at: text size.
	model := context model.
	self assert: ((model entries collect: #contents) includes: #xor:).
	
	text := 'testIt
	a := [ :test | test * test ] 
		as'.
	context := self createContextFor: text at: text size.
	model := context model.
	self assert: ((model entries collect: #contents) includes: #asMinimalRepresentation).
	
	text := 'testIt
	$c as'.
	context := self createContextFor: text at: text size.
	model := context model.
	self assert: ((model entries collect: #contents) includes: #asciiValue).
	
	text := 'testIt
	#gaga un'.
	context := self createContextFor: text at: text size.
	model := context model.
	self assert: ((model entries collect: #contents) includes: #uncapitalized).
	
	text := 'testIt
	#( 1 2 3) as'.
	context := self createContextFor: text at: text size.
	model := context model.
	self assert: ((model entries collect: #contents) includes: #asByteArray).
	
	text:='testIt
	2r1.1e2 ba'.
	context := self createContextFor: text at: text size.
	model := context model.
	self assert: ((model entries collect: #contents) includes: #basicIdentityHash).
	
	text:='testIt
	23s32 as'.
	context := self createContextFor: text at: text size.
	model := context model.
	self assert: ((model entries collect: #contents) includes: #asFraction).
]

{ #category : #tests }
NECContextTest >> testReceiverGlobal [
	| text context model |
	text := 'testIt
	Dictionary ne'.
	context := self createContextFor: text at: text size.
	model := context model.
	self assert: ((model entries collect: #contents) includes: #new).

]

{ #category : #tests }
NECContextTest >> testReceiverGlobalVarNew [
	| text context model |
	text := 'testIt
	Dictionary new fl'.
	context := self createContextFor: text at: text size.
	model := context model.
	self assert: ((model entries collect: #contents) includes: #flatCollect:).

]

{ #category : #tests }
NECContextTest >> testReceiverTempVar [
	| text context model |
	text := 'testIt
	| aha |
	aha := ''test''.
	aha pa'.
	context := self 
		createContextFor: text
		at: text size.
	model := context model.
	self assert: ((model entries collect: #contents) includes: #padLeftTo:).
	
	text := 'testIt
	| aha |
	ah := ''test''.
	ah p'.
	context := self 
		createContextFor: text
		at: text size.
	self assert: context receiverClass isNil.
	
	text := 'testIt
	| aha bili |
	aha := String.
	bili := aha.
	bili s'.
	context := self 
		createContextFor: text
		at: text size.
	model := context model.
	self assert: ((model entries collect: #contents) includes: #size).
	
	text := 'testIt
	| aha |
	aha := LargePositiveInteger.
	aha pr'.
	context := self 
		createContextFor: text
		at: text size.
	model := context model.
	self assert: ((model entries collect: #contents) includes: #primesUpTo:)
]

{ #category : #tests }
NECContextTest >> testReceiverTempVar2 [
	| text context model |
	text := 'openMenuFor: aParagraphEditor 
	| theMenu |
	context := NECContext
				controller: self
				class: model receiverClass
				source: aParagraphEditor text string
				position: aParagraphEditor caret - 1.
	editor := aParagraphEditor.
	theMenu := NECMenuMorph
				controller: self
				position: (aParagraphEditor selectionPosition: context completionToken).
	theMenu isClosed
		ifFalse: [menuMorph := theMenu]. theMenu ins'.
	context := self createContextFor: text at: text size.
	model := context model.
	self assert: ((model entries collect: #contents) includes: #insertCommonPrefixOrSelected).
	self assert: model class equals: NECTypedModel
]

{ #category : #tests }
NECContextTest >> testReceiverTempVar3 [
"if tempvar assignment is from a keyword message send (case 3), the guessed type should be 'nil' as in case for simple messages. Don't move over to other var assignments (smallint for var b)"
	| text context model |
	"case 1 guess from constant"
	text := 'testIt
	| a b |
	a := ''test''.
	b := 10.
	a as'.
	context := self 
		createContextFor: text
		at: text size.
	self assert: context receiverClass == ByteString.
	"case 2 can not guess from return value of a message send"
	text := 'testIt
	| a b |
	a _ self class.
	b _ 10.
	a as'.
	context := self 
		createContextFor: text
		at: text size.
	self assert: context receiverClass isNil.
	"case 3 can not guess from return value of a keyword message send"
	text := 'testIt
	| a b |
	a := self init:''test''.
	b := 10.
	a as'.
	context := self 
		createContextFor: text
		at: text size.
	model := context model.
	self assert: model class equals: NECUntypedModel
]

{ #category : #tests }
NECContextTest >> testUnfinishedString [
	| text context |
	text := 'testIt: aRectangle
	| a b c |
	self test: ''test it and so'.
	context := self 
		createContextFor: text
		at: text size.
	self assert: context completionToken equals: 'so'
]

{ #category : #tests }
NECContextTest >> testUntypedSelectorsOnly [
	| text context model |
	text := 'testIt: aRectangle
	| ab bc bd |
	ab '.
	context := self createContextFor: text at: text size.
	model := context model.
	self assert: model hasMessage.
	self assert: model message equals: 'press key for selectors'.
	context narrowWith: 'ab'.
	self assert: ((model entries collect: #contents) includes: #abs)
]

{ #category : #tests }
NECContextTest >> testUntypedVarsOnly [
	self checkUntypedVariablesOnly: 'testIt
	'.
	self checkUntypedVariablesOnly: '+ aTest
	'.
	self checkUntypedVariablesOnly: 'gaga: aTest
	'.
	self checkUntypedVariablesOnly: 'gaga
	^ '.
	self checkUntypedVariablesOnly: 'testIt 
	a ifTrue:[ '.
	self checkUntypedVariablesOnly: 'testIt 
	a ifTrue:[ :each'.
	self checkUntypedVariablesOnly: 'testIt 
	a ifTrue:[ :each |'.
	self checkUntypedVariablesOnly: 'testIt 
	a ifTrue:[ :each | '.
	self checkUntypedVariablesOnly: 'testIt
	<primitive: 67> 
	'.
	self checkUntypedVariablesOnly: 'testIt
	ab _'.
	self checkUntypedVariablesOnly: 'testIt
	ab _ '.
	self checkUntypedVariablesOnly: 'self compare: '.
	self checkUntypedVariablesOnly: 'self compare: x caseSensitive: '.
	self checkUntypedVariablesOnly: 'self gaga: x gugu: ('.
	self checkUntypedVariablesOnly: 'testIt
	a _ 15 + '.
	self checkUntypedVariablesOnly: 'testIt
	self hugatada: '
]
