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
	
	^ self complete: aString with: aCharacter inClass: Object
]

{ #category : #helper }
CompletionTest >> complete: aString with: aCharacter inClass: aClass [
	| node |
	
	node := self findNodeOf: aString.
	^ CompletionGuy new completionListForNode: node inserting: aCharacter
]

{ #category : #helper }
CompletionTest >> findNodeOf: aString [
	
	| offset node |	
	ast := RBParser parseFaultyMethod: aString.
	offset := aString size.
	node := ast bestNodeFor: (offset to: offset).
	^ node
]

{ #category : #tests }
CompletionTest >> testCompleteInstanceVariable [
   "for later"
	| result |
	result := self complete: 'dd |myTemp| my' with: $T.
	self assert: (result includes: 'myTemp').
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
