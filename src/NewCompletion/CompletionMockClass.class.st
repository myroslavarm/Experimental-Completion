"
Mock classes used for testing some completion functionality.
"
Class {
	#name : #CompletionMockClass,
	#superclass : #Object,
	#instVars : [
		'myInstanceVariable'
	],
	#classVars : [
		'Hello'
	],
	#pools : [
		'VTermOutputStyles'
	],
	#category : #'NewCompletion-Mock'
}

{ #category : #'as yet unclassified' }
CompletionMockClass class >> fooClass [

	^ 'bye'
]

{ #category : #'test mock' }
CompletionMockClass >> foo1 [

	^ 'hello foo1'
]

{ #category : #'test mock' }
CompletionMockClass >> fooArg: aString [

	^ aString
]
