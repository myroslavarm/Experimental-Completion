Class {
	#name : #CompletionListMorphTest,
	#superclass : #TestCase,
	#instVars : [
		'ast'
	],
	#category : #NewCompletion
}

{ #category : #tests }
CompletionListMorphTest >> testMorphCreation [
	| morph |
	
	morph := CompletionListMorph new.
	morph initializeWith: { 'Aaa'. 'BBB' }.
	morph openInWindow.
	
]

{ #category : #tests }
CompletionListMorphTest >> testMorphCreation2 [
	| morph node guy options joiner |
	joiner := CompletionJoinerWithParameters new.
	node := joiner findNodeOf: 'dd |anInstanceVariable| a' withOffset: 25.
	guy := CompletionGuy new.
	guy completionContext: UndefinedObject.
	options := guy completionListForNode: node. 
	
	morph := CompletionListMorph new.
	morph initializeWith: options.
	morph openInWindow.
	
]
