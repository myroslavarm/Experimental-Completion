Class {
	#name : #SubContextTest,
	#superclass : #NECContextTest,
	#category : #'NECompletion-Tests'
}

{ #category : #private }
SubContextTest >> createContextFor: aString at: anInteger [ 
	^ CompletionContext
		controller: CompletionController new
		class: NECTestClass
		source: aString
		position: anInteger
]
