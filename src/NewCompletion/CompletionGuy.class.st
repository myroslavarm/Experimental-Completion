Class {
	#name : #CompletionGuy,
	#superclass : #Object,
	#instVars : [
		'insertedCharacter'
	],
	#category : #NewCompletion
}

{ #category : #completion }
CompletionGuy >> completionListForNode: aRBNode inserting: aCharacter [

	insertedCharacter := aCharacter.
	^ aRBNode acceptVisitor: self
]

{ #category : #visiting }
CompletionGuy >> visitLiteralNode: aRBLiteralValueNode [
	
	(aRBLiteralValueNode value isKindOf: Symbol) ifFalse: [ ^#() ].
	"return all symbols that start with value concatenated with character"
	^ Symbol allSymbols select: [ :each | each beginsWith: aRBLiteralValueNode value asString, insertedCharacter asString ]	
]

{ #category : #visiting }
CompletionGuy >> visitMessageNode: aRBMessageNode [

	^ Symbol allSymbols select: [ :each | each beginsWith: aRBMessageNode selector asString , insertedCharacter asString ]
]

{ #category : #visiting }
CompletionGuy >> visitVariableNode: aRBVariableNode [ 
	
	^ Smalltalk globals keys select: [ :each | each beginsWith: aRBVariableNode name asString , insertedCharacter asString ]
]
