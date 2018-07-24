Class {
	#name : #CompletionListMorphTest,
	#superclass : #TestCase,
	#instVars : [
		'ast'
	],
	#category : #NewCompletion
}

{ #category : #'as yet unclassified' }
CompletionListMorphTest >> findNodeOf: aString withOffset: anInteger [ 
	| node |	
	ast := RBParser parseFaultyMethod: aString.
	node := ast bestNodeFor: (anInteger to: anInteger).
	^ node
]

{ #category : #tests }
CompletionListMorphTest >> testMorphCreation [
	| morph |
	
	morph := CompletionListMorph new.
	morph initializeWith: { 'Aaa'. 'BBB' }.
	morph openInWindow.
	
]

{ #category : #tests }
CompletionListMorphTest >> testMorphCreation2 [
	| morph aString anInteger node guy aClass aCharacter options |

	node := self findNodeOf: 'dd |anInstanceVariable| a' withOffset: 25.
	guy := CompletionGuy new.
	guy completionContext: UndefinedObject.
	options := guy completionListForNode: node inserting: $n . 
	
	morph := CompletionListMorph new.
	morph initializeWith: options.
	morph openInWindow.
	
]
