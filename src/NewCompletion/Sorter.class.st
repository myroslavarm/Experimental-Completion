"
Strategy pattern that describes the sorting functionality.

Sorter allSubclasses collect: #kind an OrderedCollection('' 'alphabetical' '' '')
"
Class {
	#name : #Sorter,
	#superclass : #Object,
	#category : #'NewCompletion-Strategy'
}

{ #category : #description }
Sorter class >> kind [ 
	^ ''
]

{ #category : #sorting }
Sorter >> sortCompletionList: aList [

	self shouldBeImplemented.
]
