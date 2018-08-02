"
A test class for the completion engine
"
Class {
	#name : #CompletionEngineTest,
	#superclass : #TestCase,
	#instVars : [
		'ast',
		'completer',
		'sorter'
	],
	#category : #'NewCompletion-Model'
}

{ #category : #tests }
CompletionEngineTest >> setUp [
	completer := CompletionEngine new.
	sorter := Sorter new.
	
	
]

{ #category : #tests }
CompletionEngineTest >> testCompleteClassName [
	| result|
	result := completer complete: 'methodName
	 Obje'.
	self assert: (result includes: 'Object').
	
]

{ #category : #tests }
CompletionEngineTest >> testCompleteClassSideMethodNames [
	"CompletionMockClass is only supposed to give a suggestion for the class side method"
	| result|
	result := completer complete: 'methodName

	CompletionMockClass foo'.
	self assert: (result includes: #fooClass).
	
	result := completer complete: 'methodName

	CompletionMockSubclass foo'.
	self assert: (result includes: #fooClass).
	self assert: (result includes: #fooClassInSubclass).
	
]

{ #category : #tests }
CompletionEngineTest >> testCompleteGlobalVariable [
	| result|
	result := completer complete: 'methodName
	 Tran'.
	self assert: (result includes: 'Transcript').
	
]

{ #category : #tests }
CompletionEngineTest >> testCompleteInstanceVariable [
 
	| result |
	result := completer complete: 'dd myInstanceV' inClass: CompletionMockClass.
	self assert: (result includes: 'myInstanceVariable').
	
	
]

{ #category : #tests }
CompletionEngineTest >> testCompleteInstanceVariableInSubClass [
   
	| result |
	result := completer complete: 'methodNames
	 myInstance' inClass: CompletionMockSubClass.
	self assert: (result includes: 'myInstanceVariable').
	
	result := completer complete: 'methodNames
	 qwerIn' inClass: CompletionMockSubClass.
	self assert: (result isEmpty)
	
]

{ #category : #tests }
CompletionEngineTest >> testCompleteMessage [
	| result|
	result := completer complete: 'methodName
	
	1 s'.
	self assert: (result includes: 'sin').

	
	
]

{ #category : #tests }
CompletionEngineTest >> testCompleteMessageSendToSelf [
	"When we complete a message to self we should only consider the hierarchy"
	| result|
	result := completer complete: 'methodName
	
	self foo' inClass: CompletionMockSubClass.
	self deny: (result includes: 'fooo2').
	self assert: (result includes: 'foo1').
	self assert: (result includes: 'foo2').
	self assert: (result includes: 'fooo').
	
	
]

{ #category : #tests }
CompletionEngineTest >> testCompleteMessageSendToSuper [
	"When we complete a message to super we should only consider the superclass"
	| result|
	result := completer complete: 'methodName
	
	super foo' inClass: CompletionMockSubClass.
	self deny: (result includes: 'foo2').
	self assert: (result includes: 'foo1').

	
	
]

{ #category : #tests }
CompletionEngineTest >> testCompleteMethodArgument [
	"We shouldn't show an instance for a self call"
	| result|
	result := completer complete: 'methodName:
	
	anArgument an'.
	self deny: (result isEmpty)

	
	
]

{ #category : #tests }
CompletionEngineTest >> testCompleteNoInstVarForSelf [
	"We shouldn't show an instance for a self call"
	| result|
	result := completer complete: 'methodName
	
	self tem' inClass: OtherCompletionMockClass.
	self assert: (result isEmpty)

	
	
]

{ #category : #tests }
CompletionEngineTest >> testCompleteSelector [
	| result|
	result := completer complete: 'methodName
	
	#bestNode'.
	self assert: (result includes: #bestNodeFor:).
	
]

{ #category : #tests }
CompletionEngineTest >> testCompleteVariableTemp [
	| result |
	result := completer complete: 'methodName

	 	|myTemp| 
		my'.
	self assert: (result includes: 'myTemp').
	
	
	
]

{ #category : #tests }
CompletionEngineTest >> testCompleteVariableTempInAssignment [
	| result|
	result := completer complete: 'methodName 
	
	|myTemp aa | 
	aa := myT'.
	self assert: (result includes: 'myTemp').
	
	
	
]

{ #category : #tests }
CompletionEngineTest >> testCompleteVariableTempMiddle [
	"The completion should work if the user places its cursor in the middle of an expression.
	Here the cursor is after the a in the a := my"
	| result |
	self flag: 'to fix why the offset doesnt work'.
	result := completer complete: 'methodName
	|myTemp aVariable | 
	a := my' offset: 24.
	self assert: (result includes: 'aVariable').
	
	result := completer complete: 'methodName
	|myTemp aVariable | 
	a := my' offset: 27.
	self assert: (result includes: 'aVariable').
	
]

{ #category : #tests }
CompletionEngineTest >> testSortAlphabetically [
	"When we complete a message to self we should only consider the hierarchy"
	| result|
	result := completer complete: 'methodName
	
	self foo' inClass: CompletionMockSubClass.
	completer sorter: AlphabeticSorter new.
	result := completer sortList: result.
	self assert: (result first = 'foo1').
	self assert: (result includes: 'foo2').
	self assert: (result includes: 'fooo').
	
	
]
