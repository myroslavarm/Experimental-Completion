Class {
	#name : #CompletionEngineTest,
	#superclass : #TestCase,
	#instVars : [
		'ast',
		'completer'
	],
	#category : #'NewCompletion-Model'
}

{ #category : #tests }
CompletionEngineTest >> setUp [
	completer := CompletionEngine new.
	
	
]

{ #category : #tests }
CompletionEngineTest >> testCompleteClassName [
	| result|
	result := completer complete: 'methodName
	 Obje'.
	self assert: (result includes: 'Object').
	
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
	self assert: (result size = 1)

	
	
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
	"The completion should work if the user places its cursor in the middle of a n expression.
	Here the cursor is after the a in the a := my"
	| result |
	result := completer complete: 'methodName
	|myTemp aVariable | 
	a := my' offset: 24.
	self assert: (result includes: 'aVariable').
	
	result := completer complete: 'methodName
	|myTemp aVariable | 
	a := my' offset: 27.
	self assert: (result includes: 'aVariable').
	
]
