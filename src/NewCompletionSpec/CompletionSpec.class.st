Class {
	#name : #CompletionSpec,
	#superclass : #ComposablePresenter,
	#instVars : [
		'button',
		'screen',
		'resultList',
		'classList'
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
					newRow: [ :newrow | newrow add: #classList ];
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
	joiner := CompletionJoiner new.
	resultList items: (joiner complete: screen text asString offset: screen getSelection last inClass: classList selectedItem)
	

]

{ #category : #accessing }
CompletionSpec >> classList [
	^ classList
]

{ #category : #accessing }
CompletionSpec >> classList: anObject [
	classList := anObject
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
	classList := self newList .
	classList items: (Smalltalk allClasses).
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
