Class {
	#name : #NewSubContextTest,
	#superclass : #NewCompletionContextTest,
	#category : #'NewCompletion-Tests'
}

{ #category : #testing }
NewSubContextTest class >> shouldInheritSelectors [
	^ true
]

{ #category : #private }
NewSubContextTest >> createContextFor: aString at: anInteger [ 
	^ CompletionContext
		controller: CompletionController new
		class: NECTestClass
		source: aString
		position: anInteger
]

{ #category : #private }
NewSubContextTest >> testUntypedSelectorsOnly [
	| text context model |
	text := 'testIt: aRectangle
	| ab bc bd |
	ab'.
	context := self createContextFor: text at: text size.
	model := context model.
	self assert: model hasMessage.
	self assert: model message equals: 'press key for selectors'.
	context narrowWith: 'ab'.
	self assert: ((model entries collect: #contents) includes: #abs)
]
