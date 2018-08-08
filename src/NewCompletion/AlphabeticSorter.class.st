"
Aplhabetical sorting.
"
Class {
	#name : #AlphabeticSorter,
	#superclass : #Sorter,
	#category : #'NewCompletion-Strategy'
}

{ #category : #accessing }
AlphabeticSorter class >> kind [

	^ 'alphabetical'
]

{ #category : #sorting }
AlphabeticSorter >> sortCompletionList: aList [

	^ aList sorted.
]
