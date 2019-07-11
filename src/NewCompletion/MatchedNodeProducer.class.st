"
I'm a little visitor. I take the specific node of the string that has to be completed and based on that node I give the list of completion results.
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

{ #category : #visiting }
MatchedNodeProducer >> methodNames [
	^ Symbol selectorTable
	
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
MatchedNodeProducer >> visitGlobalNode: aRBGlobalNode [ 
	^ self visitVariableNode: aRBGlobalNode 
]

{ #category : #visiting }
MatchedNodeProducer >> visitLiteralNode: aRBLiteralValueNode [
	| results |
	(aRBLiteralValueNode value isKindOf: Symbol) ifFalse: [ ^#() ].
	"return all symbols that start with value"
	results := OrderedCollection new.
	Symbol allSymbolTablesDo: [ :symbol |
		(symbol beginsWith: aRBLiteralValueNode value)
			ifTrue: [ results add: symbol ].
		results size >= 10 ifTrue: [ ^ results ]
	].
	^ results
]

{ #category : #visiting }
MatchedNodeProducer >> visitLiteralValueNode: aRBLiteralValueNode [ 
	^ self visitLiteralNode: aRBLiteralValueNode
]

{ #category : #visiting }
MatchedNodeProducer >> visitMessageNode:  aRBMessageNode [
	"uses the TypingVisitor and the idea of double dispatch to avoid multiple if statements"
	| receiver | 
	receiver := aRBMessageNode receiver.
	
	(receiver hasProperty: #type)
		ifTrue: [ ^ self select: (receiver propertyAt: #type) allSelectors beginningWith: aRBMessageNode selector ] .
	^ self select: Symbol selectorTable beginningWith: aRBMessageNode selector
]

{ #category : #visiting }
MatchedNodeProducer >> visitMethodNode: aRBMethodNode [ 
	^ (self select: self methodNames beginningWith: aRBMethodNode selector)
]

{ #category : #visiting }
MatchedNodeProducer >> visitNode: aNode [ 
	^aNode acceptVisitor: self
]

{ #category : #visiting }
MatchedNodeProducer >> visitParseErrorNode: aRBLiteralValueNode [
	
	^ #()
]

{ #category : #visiting }
MatchedNodeProducer >> visitPragmaNode: aPragmaNode [
	^ self select: Symbol allSymbols beginningWith: aPragmaNode selector
]

{ #category : #visiting }
MatchedNodeProducer >> visitSelfNode: aRBSelfNode [ 
	^ self visitVariableNode: aRBSelfNode 
]

{ #category : #visiting }
MatchedNodeProducer >> visitSequenceNode: aRBSequenceNode [ 
	^ #()
]

{ #category : #visiting }
MatchedNodeProducer >> visitSuperNode: aSuperNode [
	^ self visitVariableNode: aSuperNode
]

{ #category : #visiting }
MatchedNodeProducer >> visitTemporaryNode: aNode [ 
	"Sent *each time* a temporary node is found"
	^ self visitVariableNode: aNode
]

{ #category : #visiting }
MatchedNodeProducer >> visitVariableNode: aRBVariableNode [  
    aRBVariableNode isDefinition ifTrue: [ ^#() ].
    (aRBVariableNode isArgument ifTrue: [ ^#() ]).
	"using a stream to store results should be better"
	^ (self select: Smalltalk globals keys beginningWith: aRBVariableNode name) , 
	  (self select: (currentClass allSlots collect: [ :each | each name ]) beginningWith: aRBVariableNode name) ,
		(self select: aRBVariableNode methodNode temporaryNames beginningWith: aRBVariableNode name),
		(self select: aRBVariableNode methodNode argumentNames beginningWith: aRBVariableNode name),
		(self select: currentClass allClassVarNames beginningWith: aRBVariableNode name),
		(self select: (currentClass allSharedPools flatCollect: [ :each | each classVarNames]) beginningWith: aRBVariableNode name),
		(self select: self methodNames beginningWith: aRBVariableNode name)

]
