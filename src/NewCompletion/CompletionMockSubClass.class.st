Class {
	#name : #CompletionMockSubClass,
	#superclass : #CompletionMockClass,
	#category : #'NewCompletion-Mock'
}

{ #category : #'as yet unclassified' }
CompletionMockSubClass class >> fooClassInSubclass [
]

{ #category : #'test mock' }
CompletionMockSubClass >> foo2 [

	^ 'hello foo2'
]

{ #category : #'test mock' }
CompletionMockSubClass >> fooo [

	^ 42
]
