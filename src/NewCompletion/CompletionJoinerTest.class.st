Class {
	#name : #CompletionJoinerTest,
	#superclass : #TestCase,
	#instVars : [
		'ast',
		'joiner'
	],
	#category : #'NewCompletion-Model'
}

{ #category : #tests }
CompletionJoinerTest >> setUp [
	joiner := CompletionJoiner new.
	
	
]

{ #category : #tests }
CompletionJoinerTest >> testCompleteClassName [
	| result|
	result := joiner complete: 'methodName
	 Obje'.
	self assert: (result includes: 'Object').
	
]

{ #category : #tests }
CompletionJoinerTest >> testCompleteGlobalVariable [
	| result|
	result := joiner complete: 'methodName
	 Tran'.
	self assert: (result includes: 'Transcript').
	
]

{ #category : #tests }
CompletionJoinerTest >> testCompleteInstanceVariable [
 
	| result |
	result := joiner complete: 'dd myInstanceV' inClass: CompletionMockClass.
	self assert: (result includes: 'myInstanceVariable').
	
	
]

{ #category : #tests }
CompletionJoinerTest >> testCompleteInstanceVariableInSubClass [
   
	| result |
	result := joiner complete: 'methodNames
	 myInstance' inClass: CompletionMockSubClass.
	self assert: (result includes: 'myInstanceVariable').
	
	result := joiner complete: 'methodNames
	 qwerIn' inClass: CompletionMockSubClass.
	self assert: (result isEmpty)
	
]

{ #category : #tests }
CompletionJoinerTest >> testCompleteMessage [
	| result|
	result := joiner complete: 'methodName
	
	1 s'.
	self assert: (result includes: 'sin').

	
	
]

{ #category : #tests }
CompletionJoinerTest >> testCompleteSelector [
	| result|
	result := joiner complete: 'methodName
	
	#bestNode'.
	self assert: (result includes: #bestNodeFor:).
	
]

{ #category : #tests }
CompletionJoinerTest >> testCompleteVariableTemp [
	| result |
	result := joiner complete: 'methodName

	 	|myTemp| 
		my'.
	self assert: (result includes: 'myTemp').
	
	
	
]

{ #category : #tests }
CompletionJoinerTest >> testCompleteVariableTempInAssignment [
	| result|
	result := joiner complete: 'methodName 
	
	|myTemp aa | 
	aa := myT'.
	self assert: (result includes: 'myTemp').
	
	
	
]

{ #category : #tests }
CompletionJoinerTest >> testCompleteVariableTempMiddle [
	"The completion should work if the user places its cursor in the middle of a n expression.
	Here the cursor is after the a in the a := my"
	| result |
	result := joiner complete: 'methodName
	|myTemp aVariable | 
	a := my' offset: 24.
	self assert: (result includes: 'aVariable').
	
	result := joiner complete: 'methodName
	|myTemp aVariable | 
	a := my' offset: 27.
	self assert: (result includes: 'aVariable').
	
]
