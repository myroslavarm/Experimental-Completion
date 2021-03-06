Class {
	#name : #NewSubContextTest,
	#superclass : #NewCompletionContextTest,
	#category : #'NewCompletion-Tests'
}

{ #category : #testing }
NewSubContextTest class >> shouldInheritSelectors [
	^ true
]

{ #category : #private }
NewSubContextTest >> createContextFor: aString at: anInteger [ 
	^ CompletionContext
		controller: CompletionController new
		class: NECTestClass
		source: aString
		position: anInteger
]

{ #category : #private }
NewSubContextTest >> testCreateModel [
	| text context model |
	text := 'testIt: aRectangle
	aRectangle printS'.
	context := self createContextFor: text at: text size.
	model := context model.
	self assert: model title equals: ''.
	
	text := 'testIt: aRectangle
	1 ad'.
	context := self createContextFor: text at: text size.
	model := context model.
	self assert: model title equals: 'SmallInteger'.

	text := 'testIt:'.
	context := self createContextFor: text at: text size.
	model := context model.
	self assert: (model entries collect: #contents) isEmpty.

	text := 'testIt: rect
	rect is'.
	context := self createContextFor: text at: text size.
	model := context model.
	self assert: model title equals: ''
]

{ #category : #private }
NewSubContextTest >> testEmpty [
	self skip: 'does this test make sense?'.
	self createContextFor: '' at: 0
]

{ #category : #private }
NewSubContextTest >> testExpressionInIncompleteParanthesis [
	| text context model |
	self skip: 'decide on how to fix or if at all necessary'.
	text := 'testIt
	1 + (1 si'.
	context := self 
		createContextFor: text
		at: text size.
	model := context model.
	self assert: ((model entries collect: #contents) includes: #sign).
]

{ #category : #private }
NewSubContextTest >> testInTheMiddelOfAWord [
	| text context |
	self skip: 'check why fails'.
	text := 'hagada'.
	context := self 
		createContextFor: text
		at: 4.
	self assert: context completionToken equals: 'haga'
]

{ #category : #private }
NewSubContextTest >> testReceiverArgument [
	| text context model |
	self skip: 'check why fails'.
	text := 'testIt: aRectangle
	aRectangle printS'.
	context := self 
		createContextFor: text
		at: text size.
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

{ #category : #private }
NewSubContextTest >> testReceiverCascade [
	| text context model |
	self skip: 'check why fails'.
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
NewSubContextTest >> testReceiverClassVar [
	| text context model |
	text := 'testIt
	ClassAnnotation so'.
	context := self 
		createContextFor: text
		at: text size.
	model := context model.
	self assert: model title equals: 'ClassAnnotation class'
]

{ #category : #private }
NewSubContextTest >> testReceiverConstant [
	| text context model |
	self skip: 'check why fails'.
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

{ #category : #private }
NewSubContextTest >> testReceiverGlobalVarNew [
	| text context model |
	self skip: 'check why fails'.
	text := 'testIt
	Dictionary new fl'.
	context := self createContextFor: text at: text size.
	model := context model.
	self assert: ((model entries collect: #contents) includes: #flatCollect:).

]

{ #category : #private }
NewSubContextTest >> testReceiverTempVar2 [
	| text context model |
	self skip: 'check why fails'.
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
NewSubContextTest >> testReceiverTempVar3 [
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
	self assert: model title equals: ''
]

{ #category : #private }
NewSubContextTest >> testUntypedSelectorsOnly [
	| text context model |
	text := 'testIt: aRectangle
	| abs bcs bds |
	ab'.
	context := self createContextFor: text at: text size.
	model := context model.
	context narrowWith: 'ab'.
	self assert: ((model entries collect: #contents) includes: #abs)
]

{ #category : #private }
NewSubContextTest >> testUntypedVarsOnly [
	self skip: 'does this test make sense?'.
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
