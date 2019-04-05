"
Reverse order sorting: first sorted then reversed.
"
Class {
	#name : #ReverseSorter,
	#superclass : #Sorter,
	#category : #'NewCompletion-Strategy'
}

{ #category : #sorting }
ReverseSorter >> sortCompletionList: aList [

	^ (aList sorted) reversed.
]
