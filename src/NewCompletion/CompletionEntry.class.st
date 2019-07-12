"
One main Entry class instead of NECEntry functionality
"
Class {
	#name : #CompletionEntry,
	#superclass : #Object,
	#instVars : [
		'contents',
		'type'
	],
	#category : #'NewCompletion-Model'
}

{ #category : #accessing }
CompletionEntry class >> contents: aString [ 
	^ self new setContents: aString
]

{ #category : #accessing }
CompletionEntry >> completion [
	^ self contents asSymbol
]

{ #category : #accessing }
CompletionEntry >> contents [
	^contents
]

{ #category : #initialization }
CompletionEntry >> setContents: aString [ 
	contents := aString.
]

{ #category : #initialization }
CompletionEntry >> type [
	^ type
]
