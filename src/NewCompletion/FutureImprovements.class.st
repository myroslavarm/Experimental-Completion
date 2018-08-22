"
Marcus' ideas for what would be nice to implement
"
Class {
	#name : #FutureImprovements,
	#superclass : #Object,
	#category : #'NewCompletion-ToDo'
}

{ #category : #'as yet unclassified' }
FutureImprovements >> nestedBlocks [

	"only keep a certain type for a block, i.e.
	t1 := 1. -- integer
	something ifTrue: [ t1 := 3.5 ]. -- float
	t1 ... -- again, integer"
]

{ #category : #'as yet unclassified' }
FutureImprovements >> parantheses [

	"add smart characters and close brackets as soon as you open them (same as old one)"
	
	"( 1 do
	would work in the old one but in the new completion the offsets are wrong and so it's not able to 	find the error node"
]

{ #category : #'as yet unclassified' }
FutureImprovements >> pragma [

	"faulty parser does not create an error node for a pragma
	we need to add functionality to be able to complete pragmas
	
	1. make sure the parses creates the pragma node correctly
	2. alternatively, handle it in visit method node"
]
