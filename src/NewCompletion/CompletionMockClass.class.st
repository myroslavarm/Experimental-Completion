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

{ #category : #'as yet unclassified' }
CompletionMockClass >> foo1 [

	^ 'hello foo1'
]

{ #category : #'as yet unclassified' }
CompletionMockClass >> fooArg: aString [

	^ aString
]
