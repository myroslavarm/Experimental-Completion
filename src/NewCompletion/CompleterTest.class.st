Class {
	#name : #CompleterTest,
	#superclass : #TestCase,
	#instVars : [
		'ast',
		'completer'
	],
	#category : #'NewCompletion-Model'
}

{ #category : #tests }
CompleterTest >> setUp [
	completer := Completer new.
	
	
]

{ #category : #tests }
CompleterTest >> testCompleteClassName [
	| result|
	result := completer complete: 'methodName
	 Obje'.
	self assert: (result includes: 'Object').
	
]

{ #category : #tests }
CompleterTest >> testCompleteGlobalVariable [
	| result|
	result := completer complete: 'methodName
	 Tran'.
	self assert: (result includes: 'Transcript').
	
]

{ #category : #tests }
CompleterTest >> testCompleteInstanceVariable [
 
	| result |
	result := completer complete: 'dd myInstanceV' inClass: CompletionMockClass.
	self assert: (result includes: 'myInstanceVariable').
	
	
]

{ #category : #tests }
CompleterTest >> testCompleteInstanceVariableInSubClass [
   
	| result |
	result := completer complete: 'methodNames
	 myInstance' inClass: CompletionMockSubClass.
	self assert: (result includes: 'myInstanceVariable').
	
	result := completer complete: 'methodNames
	 qwerIn' inClass: CompletionMockSubClass.
	self assert: (result isEmpty)
	
]

{ #category : #tests }
CompleterTest >> testCompleteMessage [
	| result|
	result := completer complete: 'methodName
	
	1 s'.
	self assert: (result includes: 'sin').

	
	
]

{ #category : #tests }
CompleterTest >> testCompleteSelector [
	| result|
	result := completer complete: 'methodName
	
	#bestNode'.
	self assert: (result includes: #bestNodeFor:).
	
]

{ #category : #tests }
CompleterTest >> testCompleteVariableTemp [
	| result |
	result := completer complete: 'methodName

	 	|myTemp| 
		my'.
	self assert: (result includes: 'myTemp').
	
	
	
]

{ #category : #tests }
CompleterTest >> testCompleteVariableTempInAssignment [
	| result|
	result := completer complete: 'methodName 
	
	|myTemp aa | 
	aa := myT'.
	self assert: (result includes: 'myTemp').
	
	
	
]

{ #category : #tests }
CompleterTest >> testCompleteVariableTempMiddle [
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
