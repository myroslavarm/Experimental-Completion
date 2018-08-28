"
I do the completion and store the results
"
Class {
	#name : #CompletionEngine,
	#superclass : #Object,
	#instVars : [
		'ast',
		'sorter',
		'class'
	],
	#category : #'NewCompletion-Model'
}

{ #category : #completion }
CompletionEngine >> complete: aString [
	"Return a list of matched symbols for the parameter where the cursor is at the end of the string"
	^ self complete: aString inClass: UndefinedObject
]

{ #category : #completion }
CompletionEngine >> complete: aString inClass: aClass [
	
	^ self complete: aString offset: aString size inClass: aClass
]

{ #category : #completion }
CompletionEngine >> complete: aString offset: anInteger [ 

	^ self complete: aString offset: anInteger inClass: UndefinedObject.
]

{ #category : #sorting }
CompletionEngine >> complete: aString offset: anInteger inClass: aClass [

	| node guy |
	class := aClass.
	node := self findNodeOf: aString withOffset: anInteger.
	guy := MatchedNodeProducer new.
	guy completionContext: aClass.
	^ guy completionListForNode: node. 
]

{ #category : #helper }
CompletionEngine >> findNodeOf: aString withOffset: anInteger [ 
	| node |	
	ast := RBParser parseFaultyMethod: aString.
	ast doSemanticAnalysisIn: class.
	TypingVisitor new visitNode: ast.
	node := ast bestNodeFor: (anInteger to: anInteger).
	^ node
]

{ #category : #sorting }
CompletionEngine >> sortList: aList [

		^ sorter sortCompletionList: aList asOrderedCollection  
]

{ #category : #sorting }
CompletionEngine >> sorter: aSorter [

	sorter := aSorter
]
