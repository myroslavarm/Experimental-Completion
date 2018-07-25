Class {
	#name : #CompletionTest,
	#superclass : #TestCase,
	#instVars : [
		'ast'
	],
	#category : #NewCompletion
}

{ #category : #tests }
CompletionTest >> testCompleteInstanceVariable [
   "for later"
	| result joiner |
	joiner := CompletionJoinerWithParameters new.
	result := joiner complete: 'dd myInstance' with: $V inClass: CompletionMockClass.
	self assert: (result includes: 'myInstanceVariable').
	"add metod to RBVariableNode.
	how to get all temps: the class) -- instanceVariableNames
	but we need to set a name on the ast somehow.
	"	
	
]

{ #category : #tests }
CompletionTest >> testCompleteInstanceVariableInSubClass [
   "for later"
	| result joiner |
	joiner := CompletionJoinerWithParameters new.
	result := joiner complete: 'dd myInstance' with: $V inClass: CompletionMockSubClass.
	self assert: (result includes: 'myInstanceVariable').
	"add metod to RBVariableNode.
	how to get all temps: the class) -- instanceVariableNames
	but we need to set a name on the ast somehow.
	"	
	
]

{ #category : #tests }
CompletionTest >> testCompleteMessage [
	| result joiner |
	joiner := CompletionJoinerWithParameters new.
	result := joiner complete: 'method 1 s' with: $i.
	self assert: (result includes: 'sin').
	"add method to RBMessageNode.
	how to get all method names: Symbol selectorTable.
	"
	
	
]

{ #category : #tests }
CompletionTest >> testCompleteSelector [
	| result joiner |
	joiner := CompletionJoinerWithParameters new.
	result := joiner complete: 'dd #bestNode' with: $F.
	self assert: (result includes: #bestNodeFor:).
	
]

{ #category : #tests }
CompletionTest >> testCompleteVariableGlobal [
	| result joiner |
	joiner := CompletionJoinerWithParameters new.
	result := joiner complete: 'dd Obje' with: $c.
	self assert: (result includes: 'Object').
	"add method to RBVariableNode.
	how to get all globals: Smalltalk globals -- returns associations, get 'key'.
	"
	
	
]

{ #category : #tests }
CompletionTest >> testCompleteVariableTemp [
	| result joiner |
	joiner := CompletionJoinerWithParameters new.
	result := joiner complete: 'dd |myTemp| my' with: $T.
	self assert: (result includes: 'myTemp').
	"add method to RBVariableNode.
	how to get all temps: RBMethodnode (ast root) -- temporaryNames.
	"
	
	
]

{ #category : #tests }
CompletionTest >> testCompleteVariableTempInAssignment [
	| result joiner |
	joiner := CompletionJoinerWithParameters new.
	result := joiner complete: 'dd |myTemp aa | aa := my' with: $T.
	self assert: (result includes: 'myTemp').
	"add method to RBVariableNode.
	how to get all temps: RBMethodnode (ast root) -- temporaryNames.
	"
	
	
]

{ #category : #tests }
CompletionTest >> testCompleteVariableTempMiddle [
	| result joiner |
	joiner := CompletionJoinerWithParameters new.
	result := joiner complete: 'dd |myTemp aVariable | a := my' with: $V offset: 24.
	self assert: (result includes: 'aVariable').
	"add method to RBVariableNode.
	how to get all temps: RBMethodnode (ast root) -- temporaryNames.
	"
	
	
]
