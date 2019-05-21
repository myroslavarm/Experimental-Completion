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
NECContextTest >> testBlockTemporaries [
	| text temps context |
	text := 'testIt
	| a b c |
	a _ [ :each | |d | ^d].
	^self'.
	context := self 
		createContextFor: text
		at: 39.
	temps := context temporaries collect: [ :each | each contents ].
	self assert: temps size = 5.
	self assert: temps first = 'a'.
	self assert: temps second = 'b'.
	self assert: temps third = 'c'.
	self assert: temps fourth = 'each'.
	self assert: temps fifth = 'd'
]

{ #category : #tests }
NECContextTest >> testBlockTemporariesBoxed [
	| text temps context |
	text := 'testIt
	| a b c |
	a := [ :each | |d | d = a ifTrue:[ |x|  ] ifFalse:[ |y|.
	^self'.
	context := self 
		createContextFor: text
		at: 73.
	temps := context temporaries collect: [ :each | each contents ].
	self assert: temps size = 5.
	self assert: temps first = 'a'.
	self assert: temps second = 'b'.
	self assert: temps third = 'c'.
	self assert: temps fourth = 'each'.
	self assert: temps fifth = 'd'.

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
	self assert: context completionToken = ''
]

{ #category : #tests }
NECContextTest >> testCreateModel [
	| text context |
	text := 'testIt: aRectangle
	aRectangle printS'.
	context := self createContextFor: text at: text size.
	self assert: context createModel class == NECTypedModel.
	text := 'testIt:'.
	context := self createContextFor: text at: text size.
	self assert: context createModel class = NECUntypedModel.
	text := 'testIt: rect
	rect is'.
	context := self createContextFor: text at: text size.
	self assert: context createModel class = NECUntypedModel
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
	| text context |
	text := 'testIt: aRectangle
	aRectangle printS'.
	context := self 
		createContextFor: text
		at: text size.
	self assert: context receiverClass == Rectangle.
	text := 'testIt: rect
	rect is'.
	context := self 
		createContextFor: text
		at: text size.
	self assert: context receiverClass isNil
]

{ #category : #tests }
NECContextTest >> testReceiverCascade [
	| text context |
	text := 'testIt
	| b |
	b _ Stream new.
	b 
		nextPutAll: ''test''; 
		nextPut: $c;
		s'.
	context := self createContextFor: text at: text size.
	self assert: context receiverClass == Stream.
	text := 'testIt
	| b |
	b _ Stream new
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
	text := 'testIt: aStream
	aStream
		nextPutAll: ''test''; 
		nextPut: $c with: true;
		s'.
	context := self createContextFor: text at: text size.
	self assert: context receiverClass == Stream
]

{ #category : #tests }
NECContextTest >> testReceiverClassVar [
	| text context |
	text := 'testIt
	ClassVar '.
	context := self 
		createContextFor: text
		at: text size.
	self assert: context receiverClass == ByteString
]

{ #category : #tests }
NECContextTest >> testReceiverConstant [
	| text context |
	text := 'testIt
	15r16 printS'.
	context := self createContextFor: text at: text size.
	self assert: context receiverClass == SmallInteger.
	text := 'testIt
	''test'' printS'.
	context := self createContextFor: text at: text size.
	self assert: context receiverClass == ByteString.
	text := 'testIt
	true ifTrue:'.
	context := self createContextFor: text at: text size.
	self assert: context receiverClass == True.
	text := 'testIt
	false  "this is it"
		printStr'.
	context := self createContextFor: text at: text size.
	self assert: context receiverClass == False.
	text := 'testIt
	a _ [ :test | test * test ] 
		v'.
	context := self createContextFor: text at: text size.
	self assert: context receiverClass == BlockClosure.
	text := 'testIt
	$c as'.
	context := self createContextFor: text at: text size.
	self assert: context receiverClass == Character.
	text := 'testIt
	#gaga as'.
	context := self createContextFor: text at: text size.
	self assert: context receiverClass == Symbol.
	text := 'testIt
	#( 1 2 3) as'.
	context := self createContextFor: text at: text size.
	self assert: context receiverClass == Array.
	text:='testIt
	2r1.1e2 as'.
	context := self createContextFor: text at: text size.
	self assert: (context receiverClass includesBehavior: Float).
	text:='testIt
	23s32 as'.
	context := self createContextFor: text at: text size.
	self assert: context receiverClass == ScaledDecimal.

]

{ #category : #tests }
NECContextTest >> testReceiverGlobal [
	| text context |
	text := 'testIt
	Dictionary n'.
	context := self createContextFor: text at: text size.
	self assert: context receiverClass == Dictionary class.

]

{ #category : #tests }
NECContextTest >> testReceiverGlobalVarNew [
	| text context |
	text := 'testIt
	Dictionary new a'.
	context := self createContextFor: text at: text size.
	self assert: context receiverClass == Dictionary.

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
	a _ ''test''.
	b _ 10.
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
NECContextTest >> testTemporaries [
	| text temps context |
	text := 'testIt: aRectangle
	| a b c |
	a _ [ :each | |d | ^d].
	^self'.
	context := self 
		createContextFor: text
		at: text size.
	temps := context temporaries collect: [ :each | each contents ].
	self assert: temps size = 4.
	self assert: temps first = 'aRectangle'.
	self assert: temps second = 'a'.
	self assert: temps third = 'b'.
	self assert: temps fourth = 'c'
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
	self assert: context completionToken = 'so'
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
	self assert: model message = 'press key for selectors'.
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
