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
MatchingRecentlyUsed >> emptyCacheBasedOnCompiledMethod: aCompiledMethod [ 
	messages isEmpty ifFalse: [
		messages remove: aCompiledMethod ].

	"aCompiledMethod allLiterals do: [ :l |
	
		l class = GlobalVariable 
			ifTrue: [ globals remove: l value ] ]"
]

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

{ #category : #testing }
MatchingRecentlyUsed >> globalsIsEmpty [
	^ globals isEmpty
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

{ #category : #testing }
MatchingRecentlyUsed >> messagesIsEmpty [ 
	^ messages isEmpty
]
