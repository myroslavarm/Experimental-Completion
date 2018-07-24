Class {
	#name : #CompletionTest,
	#superclass : #TestCase,
	#instVars : [
		'ast'
	],
	#category : #NewCompletion
}

{ #category : #helper }
CompletionTest >> complete: aString with: aCharacter [
	
	^ self complete: aString with: aCharacter inClass: UndefinedObject
]

{ #category : #helper }
CompletionTest >> complete: aString with: aCharacter inClass: aClass [
	
	^ self complete: aString with: aCharacter offset: aString size inClass: aClass
]

{ #category : #completion }
CompletionTest >> complete: aString with: aCharacter offset: anInteger [ 
	
	^ self complete: aString with: aCharacter offset: anInteger inClass: UndefinedObject.
]

{ #category : #completion }
CompletionTest >> complete: aString with: aCharacter offset: anInteger inClass: aClass [
	| node guy |
	
	node := self findNodeOf: aString withOffset: anInteger.
	guy := CompletionGuy new.
	guy completionContext: aClass.
	^ guy completionListForNode: node inserting: aCharacter . 
]

{ #category : #helper }
CompletionTest >> findNodeOf: aString [
	
	| offset node |	
	ast := RBParser parseFaultyMethod: aString.
	offset := aString size.
	node := ast bestNodeFor: (offset to: offset).
	^ node
]

{ #category : #completion }
CompletionTest >> findNodeOf: aString withOffset: anInteger [ 
	| node |	
	ast := RBParser parseFaultyMethod: aString.
	node := ast bestNodeFor: (anInteger to: anInteger).
	^ node
]

{ #category : #tests }
CompletionTest >> testCompleteInstanceVariable [
   "for later"
	| result |
	result := self complete: 'dd myInstance' with: $V inClass: CompletionMockClass.
	self assert: (result includes: 'myInstanceVariable').
	self halt.
	"add metod to RBVariableNode.
	how to get all temps: the class) -- instanceVariableNames
	but we need to set a name on the ast somehow.
	"	
	
]

{ #category : #tests }
CompletionTest >> testCompleteInstanceVariableInSubClass [
   "for later"
	| result |
	result := self complete: 'dd myInstance' with: $V inClass: CompletionMockSubClass.
	self assert: (result includes: 'myInstanceVariable').
	"add metod to RBVariableNode.
	how to get all temps: the class) -- instanceVariableNames
	but we need to set a name on the ast somehow.
	"	
	
]

{ #category : #tests }
CompletionTest >> testCompleteMessage [
	| result |
	result := self complete: 'method 1 s' with: $i.
	self assert: (result includes: 'sin').
	"add method to RBMessageNode.
	how to get all method names: Symbol selectorTable.
	"
	
	
]

{ #category : #tests }
CompletionTest >> testCompleteSelector [
	| result |
	result := self complete: 'dd #bestNode' with: $F.
	self assert: (result includes: #bestNodeFor:).
	
]

{ #category : #tests }
CompletionTest >> testCompleteVariableGlobal [
	| result |
	result := self complete: 'dd Obje' with: $c.
	self assert: (result includes: 'Object').
	"add method to RBVariableNode.
	how to get all globals: Smalltalk globals -- returns associations, get 'key'.
	"
	
	
]

{ #category : #tests }
CompletionTest >> testCompleteVariableTemp [
	| result |
	result := self complete: 'dd |myTemp| my' with: $T.
	self assert: (result includes: 'myTemp').
	"add method to RBVariableNode.
	how to get all temps: RBMethodnode (ast root) -- temporaryNames.
	"
	
	
]

{ #category : #tests }
CompletionTest >> testCompleteVariableTempInAssignment [
	| result |
	result := self complete: 'dd |myTemp aa | aa := my' with: $T.
	self assert: (result includes: 'myTemp').
	"add method to RBVariableNode.
	how to get all temps: RBMethodnode (ast root) -- temporaryNames.
	"
	
	
]

{ #category : #tests }
CompletionTest >> testCompleteVariableTempMiddle [
	| result |
	result := self complete: 'dd |myTemp aVariable | a := my' with: $V offset: 24.
	self assert: (result includes: 'aVariable').
	"add method to RBVariableNode.
	how to get all temps: RBMethodnode (ast root) -- temporaryNames.
	"
	
	
]
