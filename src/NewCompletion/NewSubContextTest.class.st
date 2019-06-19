Class {
	#name : #NewSubContextTest,
	#superclass : #NewCompletionContextTest,
	#category : #'NewCompletion-Tests'
}

{ #category : #private }
NewSubContextTest >> createContextFor: aString at: anInteger [ 
	^ CompletionContext
		controller: CompletionController new
		class: NECTestClass
		source: aString
		position: anInteger
]
