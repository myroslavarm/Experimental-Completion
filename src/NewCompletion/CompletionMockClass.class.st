Class {
	#name : #CompletionMockClass,
	#superclass : #Object,
	#instVars : [
		'myInstanceVariable'
	],
	#category : #'NewCompletion-Mock'
}

{ #category : #'as yet unclassified' }
CompletionMockClass class >> fooClass [

	^ 'bye'
]

{ #category : #'as yet unclassified' }
CompletionMockClass >> foo1 [

	^ 'hello foo1'
]
