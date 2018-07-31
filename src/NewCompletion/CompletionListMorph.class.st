Class {
	#name : #CompletionListMorph,
	#superclass : #Morph,
	#instVars : [
		'astNode',
		'list',
		'options'
	],
	#category : #'NewCompletion-UI'
}

{ #category : #initialization }
CompletionListMorph >> initializeWith: someOptions [
	options := someOptions.
	list := FTTableMorph new.
	
	list
		dataSource:
			(FTEasyListDataSource new
				elements: options;
				display: [ :item | item ]).
	self addMorph: list.
	self changeTableLayout.
	list vResizing: #spaceFill.
	list hResizing: #spaceFill.
	self extent: 100 @ 100
]

{ #category : #accessing }
CompletionListMorph >> options: aCollection [ 
	options := aCollection.
]
