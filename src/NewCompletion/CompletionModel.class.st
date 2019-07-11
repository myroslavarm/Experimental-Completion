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
		'entries'
	],
	#category : #'NewCompletion-Model'
}

{ #category : #accessing }
CompletionModel >> arrowString [

 	^ completionToken
]

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

 	| seed matchLengths prefixLength |
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
	^entries ifNil: [entries := self initEntries ].
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
CompletionModel >> initEntries [
	| producer temp |
	producer := MatchedNodeProducer new.
	producer completionContext: clazz.
	temp := (producer completionListForNode: node) asOrderedCollection. 
	^ temp collect: [ :each | NECGlobalEntry contents: each ]
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

{ #category : #action }
CompletionModel >> narrowString [

 	^ completionToken
]

{ #category : #action }
CompletionModel >> narrowWith: aString [ 
	completionToken := aString ifNil: [  '' ].
	node narrowWith: completionToken.
	entries := nil
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
	^ self entries isNotEmpty
]

{ #category : #accessing }
CompletionModel >> title [
	| type |
	[
	type := node receiver propertyAt: #type ifAbsent: [ ^ '' ].
	^ type name
	] on: Error do: [ :e | ^ '' ]
]
