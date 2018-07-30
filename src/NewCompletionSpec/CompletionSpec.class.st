Class {
	#name : #CompletionSpec,
	#superclass : #ComposablePresenter,
	#instVars : [
		'button',
		'screen',
		'resultList'
	],
	#category : #NewCompletionSpec
}

{ #category : #specs }
CompletionSpec class >> defaultSpec [

	^ SpecLayout composed
		newRow: [ :row | 
			row newColumn: [ :leftColumn |
				leftColumn
					newRow: [ :newrow | newrow add: #screen ];
					newRow: [ :newrow | newrow add: #button ]];
			newColumn: [ :rightColumn | rightColumn add: #resultList ]];
		yourself.
]

{ #category : #initialization }
CompletionSpec >> button [

	^ button
]

{ #category : #accessing }
CompletionSpec >> button: anObject [
	button := anObject
]

{ #category : #initialization }
CompletionSpec >> buttonPressed [
	| joiner |
	"resultList items: (1 to: 35 atRandom)"
	joiner := CompletionJoinerWithParameters new.
	resultList items: (joiner complete: screen text asString offset: screen getSelection last inClass: UndefinedObject)
	

]

{ #category : #initialization }
CompletionSpec >> extent [

	^ 400@800
]

{ #category : #initialization }
CompletionSpec >> initializePresenter [

	button action: [ self buttonPressed ]
]

{ #category : #initialization }
CompletionSpec >> initializeWidgets [

	screen := self newText .
	screen autoAccept: true.
	button := self newButton .
	screen text: 'tryMethod |anInstanceVariable| a'.
	button label: 'Click me'.
	
	resultList := self newList
]

{ #category : #accessing }
CompletionSpec >> resultList [
	^ resultList
]

{ #category : #accessing }
CompletionSpec >> resultList: anObject [
	resultList := anObject
]

{ #category : #initialization }
CompletionSpec >> screen [

	^ screen
]

{ #category : #accessing }
CompletionSpec >> screen: anObject [
	screen := anObject
]

{ #category : #initialization }
CompletionSpec >> title [

	^ 'Spec for completion'
]
