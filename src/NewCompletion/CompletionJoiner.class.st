Class {
	#name : #CompletionJoiner,
	#superclass : #Object,
	#instVars : [
		'ast'
	],
	#category : #'NewCompletion-Model'
}

{ #category : #helper }
CompletionJoiner >> complete: aString [
	
	^ self complete: aString inClass: UndefinedObject
]

{ #category : #helper }
CompletionJoiner >> complete: aString inClass: aClass [
	
	^ self complete: aString offset: aString size inClass: aClass
]

{ #category : #completion }
CompletionJoiner >> complete: aString offset: anInteger [ 
	
	^ self complete: aString offset: anInteger inClass: UndefinedObject.
]

{ #category : #completion }
CompletionJoiner >> complete: aString offset: anInteger inClass: aClass [
	| node guy |
	node := self findNodeOf: aString withOffset: anInteger.
	guy := CompletionGuy new.
	guy completionContext: aClass.
	^ guy completionListForNode: node. 
]

{ #category : #helper }
CompletionJoiner >> findNodeOf: aString [
	
	| offset node |	
	ast := RBParser parseFaultyMethod: aString.
	offset := aString size.
	node := ast bestNodeFor: (offset to: offset).
	^ node
]

{ #category : #helper }
CompletionJoiner >> findNodeOf: aString withOffset: anInteger [ 
	| node |	
	ast := RBParser parseFaultyMethod: aString.
	node := ast bestNodeFor: (anInteger to: anInteger).
	^ node
]

{ #category : #completion }
CompletionJoiner >> showListFor: aString nextCharacter: aCharacter offset: anInteger inClass: aClass [ 

	| node guy options morph |
	node := self findNodeOf: aString withOffset: anInteger.
	guy := CompletionGuy new.
	guy completionContext: aClass.
	options := guy completionListForNode: node inserting: aCharacter . 
	
	morph := CompletionListMorph new.
	morph initializeWith: options.
	morph openInWindow.

]
