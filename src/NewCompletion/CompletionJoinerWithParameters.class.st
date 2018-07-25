Class {
	#name : #CompletionJoinerWithParameters,
	#superclass : #Object,
	#instVars : [
		'ast'
	],
	#category : #NewCompletion
}

{ #category : #helper }
CompletionJoinerWithParameters >> complete: aString with: aCharacter [
	
	^ self complete: aString with: aCharacter inClass: UndefinedObject
]

{ #category : #helper }
CompletionJoinerWithParameters >> complete: aString with: aCharacter inClass: aClass [
	
	^ self complete: aString with: aCharacter offset: aString size inClass: aClass
]

{ #category : #completion }
CompletionJoinerWithParameters >> complete: aString with: aCharacter offset: anInteger [ 
	
	^ self complete: aString with: aCharacter offset: anInteger inClass: UndefinedObject.
]

{ #category : #completion }
CompletionJoinerWithParameters >> complete: aString with: aCharacter offset: anInteger inClass: aClass [
	| node guy |
	
	node := self findNodeOf: aString withOffset: anInteger.
	guy := CompletionGuy new.
	guy completionContext: aClass.
	^ guy completionListForNode: node inserting: aCharacter . 
]

{ #category : #helper }
CompletionJoinerWithParameters >> findNodeOf: aString [
	
	| offset node |	
	ast := RBParser parseFaultyMethod: aString.
	offset := aString size.
	node := ast bestNodeFor: (offset to: offset).
	^ node
]

{ #category : #helper }
CompletionJoinerWithParameters >> findNodeOf: aString withOffset: anInteger [ 
	| node |	
	ast := RBParser parseFaultyMethod: aString.
	node := ast bestNodeFor: (anInteger to: anInteger).
	^ node
]

{ #category : #completion }
CompletionJoinerWithParameters >> showListFor: aString nextCharacter: aCharacter offset: anInteger inClass: aClass [ 

	| node guy options morph |
	node := self findNodeOf: aString withOffset: anInteger.
	guy := CompletionGuy new.
	guy completionContext: aClass.
	options := guy completionListForNode: node inserting: aCharacter . 
	
	morph := CompletionListMorph new.
	morph initializeWith: options.
	morph openInWindow.

]
