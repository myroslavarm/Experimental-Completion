"
I am a model class which is used instead of the typed, untyped and empty NECModel's.
"
Class {
	#name : #CompletionModel,
	#superclass : #Object,
	#instVars : [
		'clazz',
		'node',
		'completionToken'
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

{ #category : #action }
CompletionModel >> narrowWith: aString [ 
	completionToken := aString.
	aString isNil ifTrue: [ completionToken := '' ]
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
	| type |
	[
	type := node receiver propertyAt: #type ifAbsent: [ ^ '' ].
	^ type name
	] on: Error do: [ :e | ^ '' ]
]
