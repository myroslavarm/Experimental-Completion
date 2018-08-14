"
I'm a matcher for recently used/modifed/created methods and variables
"
Class {
	#name : #MatchingRecentlyUsed,
	#superclass : #Object,
	#instVars : [
		'messages',
		'globals'
	],
	#category : #'NewCompletion-Model'
}

{ #category : #'as yet unclassified' }
MatchingRecentlyUsed >> fillCacheBasedOnCompiledMethod: aCompiledMethod [ 
	messages addAll: aCompiledMethod messages.
	messages add: aCompiledMethod selector.

	aCompiledMethod allLiterals do: [ :l |
	
		l class = GlobalVariable 
			ifTrue: [ globals add: l value ] ]
]

{ #category : #testing }
MatchingRecentlyUsed >> globalsIncludes: aClass [ 
	^ globals includes: aClass
]

{ #category : #initialization }
MatchingRecentlyUsed >> initialize [

	super initialize.
	messages := OrderedCollection new.
	globals := OrderedCollection new.
]

{ #category : #testing }
MatchingRecentlyUsed >> messagesIncludes: aSymbol [ 
	^ messages includes: aSymbol
]
