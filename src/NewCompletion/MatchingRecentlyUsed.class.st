"
I'm a matcher for recently used/modifed/created methods and variables
"
Class {
	#name : #MatchingRecentlyUsed,
	#superclass : #Object,
	#instVars : [
		'messages'
	],
	#category : #'NewCompletion-Model'
}

{ #category : #'as yet unclassified' }
MatchingRecentlyUsed >> fillCacheBasedOnCompiledMethod: aCompiledMethod [ 
	messages addAll: aCompiledMethod messages
]

{ #category : #initialization }
MatchingRecentlyUsed >> initialize [

	super initialize.
	messages := OrderedCollection new.
]

{ #category : #testing }
MatchingRecentlyUsed >> messagesIncludes: aSymbol [ 
	^ messages includes: aSymbol
]
