"
I am a model class which is used instead of the typed, untyped and empty NECModel's.
"
Class {
	#name : #CompletionModel,
	#superclass : #Object,
	#instVars : [
		'clazz',
		'node',
		'completionToken',
		'currentClass'
	],
	#category : #'NewCompletion-Model'
}

{ #category : #accessing }
CompletionModel >> clazz [
	^ clazz
]

{ #category : #accessing }
CompletionModel >> clazz: anObject [
	clazz := anObject.
	clazz isNil ifTrue: [ clazz := UndefinedObject ]
]

{ #category : #accessing }
CompletionModel >> commonPrefix [
	"Longest match among the typed text and all menu entries"

	| entries seed matchLengths prefixLength |
	entries := self entries.
	seed := entries first contents asString.
	matchLengths := entries allButFirst
		collect: [ :entry | seed charactersExactlyMatching: entry contents asString ]
		thenSelect: [ :e | e >= completionToken size ].
	prefixLength := matchLengths isEmpty
		ifTrue: [ 0 ]
		ifFalse: [ matchLengths min ].
	^ seed first: prefixLength.
]

{ #category : #accessing }
CompletionModel >> completionAt: aNumber [
	| entry |
	
	entry := (self entries at: aNumber) completion separateKeywords.
	^ NECPreferences spaceAfterCompletion 
		ifTrue: [ entry, ' ' ]
		ifFalse: [ entry ]. 
	
	
]

{ #category : #accessing }
CompletionModel >> entries [
	| producer temp |
	producer := MatchedNodeProducer new.
	producer completionContext: clazz.
	temp := (producer completionListForNode: node) asOrderedCollection. 
	^ temp collect: [ :each | NECGlobalEntry contents: each ]
]

{ #category : #accessing }
CompletionModel >> entryCount [
	^ self entries size
]

{ #category : #accessing }
CompletionModel >> hasMessage [
	^ self message notNil
]

{ #category : #accessing }
CompletionModel >> initialize [ 
	completionToken := ''.
	clazz := UndefinedObject
]

{ #category : #accessing }
CompletionModel >> isEmpty [ 
	^ self entries isEmpty
]

{ #category : #accessing }
CompletionModel >> message [
	^self isEmpty 
		ifTrue: ['no completions found'] 
		ifFalse: [nil]
]

{ #category : #accessing }
CompletionModel >> narrowString [
	
	^ completionToken
]

{ #category : #'as yet unclassified' }
CompletionModel >> narrowWith: aString [ 

	completionToken := aString ifNil: [  '' ].
	node narrowWith: completionToken.
]

{ #category : #accessing }
CompletionModel >> node [
	^ node
]

{ #category : #accessing }
CompletionModel >> node: anObject [
	node := anObject
]

{ #category : #accessing }
CompletionModel >> notEmpty [ 
	^ self isEmpty not
]

{ #category : #accessing }
CompletionModel >> title [

	^ (node typeForCompletionIfAbsent: [ ^ '' ]) name
]
