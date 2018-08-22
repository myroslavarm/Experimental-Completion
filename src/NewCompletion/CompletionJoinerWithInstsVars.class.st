"
a little trial class
"
Class {
	#name : #CompletionJoinerWithInstsVars,
	#superclass : #Object,
	#instVars : [
		'methodCode',
		'nextCharacter',
		'offset',
		'inClass'
	],
	#category : #'NewCompletion-ToDo'
}

{ #category : #completion }
CompletionJoinerWithInstsVars >> findNodeOf: aString withOffset: anInteger [ 
	| node ast |	
	ast := RBParser parseFaultyMethod: aString.
	node := ast bestNodeFor: (anInteger to: anInteger).
	^ node
]

{ #category : #accessing }
CompletionJoinerWithInstsVars >> inClass [
	^ inClass
]

{ #category : #accessing }
CompletionJoinerWithInstsVars >> inClass: anObject [
	inClass := anObject
]

{ #category : #accessing }
CompletionJoinerWithInstsVars >> methodCode [
	^ methodCode
]

{ #category : #'as yet unclassified' }
CompletionJoinerWithInstsVars >> methodCode: aString [ 
	methodCode := aString
]

{ #category : #accessing }
CompletionJoinerWithInstsVars >> nextCharacter [
	^ nextCharacter
]

{ #category : #accessing }
CompletionJoinerWithInstsVars >> nextCharacter: anObject [
	nextCharacter := anObject
]

{ #category : #accessing }
CompletionJoinerWithInstsVars >> offset [
	^ offset
]

{ #category : #accessing }
CompletionJoinerWithInstsVars >> offset: anObject [
	offset := anObject
]

{ #category : #'as yet unclassified' }
CompletionJoinerWithInstsVars >> showList [

	| node guy options morph |
	node := self findNodeOf: methodCode withOffset: offset.
	guy := MatchedNodeProducer new.
	guy completionContext: inClass.
	options := guy completionListForNode: node inserting: nextCharacter . 
	
	morph := CompletionListMorph new.
	morph initializeWith: options.
	morph openInWindow.

]
