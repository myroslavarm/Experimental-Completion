Class {
	#name : #CompletionGuy,
	#superclass : #Object,
	#instVars : [
		'insertedCharacter',
		'currentClass'
	],
	#category : #NewCompletion
}

{ #category : #accessing }
CompletionGuy >> completionContext: aClass [ 
	currentClass := aClass.
]

{ #category : #completion }
CompletionGuy >> completionListForNode: aRBNode inserting: aCharacter [

	insertedCharacter := aCharacter.
	^ aRBNode acceptVisitor: self
]

{ #category : #visiting }
CompletionGuy >> select: aCollection beginningWith: aString [
	^ aCollection select: [ :each | each beginsWith: aString asString , insertedCharacter asString ]
	
]

{ #category : #visiting }
CompletionGuy >> visitLiteralNode: aRBLiteralValueNode [
	
	(aRBLiteralValueNode value isKindOf: Symbol) ifFalse: [ ^#() ].
	"return all symbols that start with value concatenated with character"
	^ self select: Symbol allSymbols beginningWith: aRBLiteralValueNode value
]

{ #category : #visiting }
CompletionGuy >> visitMessageNode: aRBMessageNode [

	^ self select: Symbol allSymbols beginningWith: aRBMessageNode selector
]

{ #category : #visiting }
CompletionGuy >> visitVariableNode: aRBVariableNode [ 
	
	^ (self select: Smalltalk globals keys beginningWith: aRBVariableNode name) , 
	  (self select: (currentClass allSlots collect: [ :each | each name ]) beginningWith: aRBVariableNode name) ,
		(self select: aRBVariableNode methodNode temporaryNames beginningWith: aRBVariableNode name)
]
