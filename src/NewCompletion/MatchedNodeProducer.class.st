"
I'm a little visitor
"
Class {
	#name : #MatchedNodeProducer,
	#superclass : #Object,
	#instVars : [
		'currentClass'
	],
	#category : #'NewCompletion-Model'
}

{ #category : #accessing }
MatchedNodeProducer >> completionContext: aClass [ 
	currentClass := aClass.
]

{ #category : #completion }
MatchedNodeProducer >> completionListForNode: aRBNode [

	^ aRBNode acceptVisitor: self
]

{ #category : #utilities }
MatchedNodeProducer >> select: aCollection beginningWith: aString [
	"Set withAll: is needed to convert potential IdentitySets to regular Sets"
	^ Set withAll: (aCollection select: [ :each | each beginsWith: aString asString ])
]

{ #category : #visiting }
MatchedNodeProducer >> visitArgumentNode: anArgumentNode [
	"Sent *each time* an argument node is found"
	^ self visitVariableNode: anArgumentNode
]

{ #category : #visiting }
MatchedNodeProducer >> visitLiteralNode: aRBLiteralValueNode [
	
	(aRBLiteralValueNode value isKindOf: Symbol) ifFalse: [ ^#() ].
	"return all symbols that start with value"
	^ self select: Symbol allSymbols beginningWith: aRBLiteralValueNode value
]

{ #category : #visiting }
MatchedNodeProducer >> visitMessageNode:  aRBMessageNode [
	| receiver | 
	receiver := aRBMessageNode receiver.
	receiver isSelf 	
		ifTrue: [ ^ self select: currentClass allSelectors beginningWith: aRBMessageNode selector ].
	receiver isSuper 	
		ifTrue: [ ^ self select: currentClass superclass allSelectors beginningWith: aRBMessageNode selector ].
	(receiver isVariable and: [(Smalltalk globals includesKey: receiver name)])
		ifTrue: [ ^ self select: (Smalltalk globals at: receiver name) class allSelectors beginningWith: aRBMessageNode selector].
	^ self select: Symbol selectorTable beginningWith: aRBMessageNode selector
]

{ #category : #visiting }
MatchedNodeProducer >> visitTemporaryNode: aNode [ 
	"Sent *each time* a temporary node is found"
	^ self visitVariableNode: aNode
]

{ #category : #visiting }
MatchedNodeProducer >> visitVariableNode: aRBVariableNode [  
    (aRBVariableNode isDefinition and: [ aRBVariableNode parent defines: aRBVariableNode name ])ifTrue: [ ^#() ].
    (aRBVariableNode isArgument ifTrue: [ ^#() ]).
	"using a stream to store results should be better"
	^ (self select: Smalltalk globals keys beginningWith: aRBVariableNode name) , 
	  (self select: (currentClass allSlots collect: [ :each | each name ]) beginningWith: aRBVariableNode name) ,
		(self select: aRBVariableNode methodNode temporaryNames beginningWith: aRBVariableNode name),
		(self select: aRBVariableNode methodNode argumentNames beginningWith: aRBVariableNode name),
		(self select: currentClass allClassVarNames beginningWith: aRBVariableNode name),
		(self select: (currentClass allSharedPools flatCollect: [ :each | each classVarNames]) beginningWith: aRBVariableNode name).

]
