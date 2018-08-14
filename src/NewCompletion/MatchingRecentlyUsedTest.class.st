Class {
	#name : #MatchingRecentlyUsedTest,
	#superclass : #TestCase,
	#category : #'NewCompletion-Model'
}

{ #category : #tests }
MatchingRecentlyUsedTest >> foo [

	| ord | 
	ord := OrderedCollection  new.
	self foo2.
	ord isEmpty ifTrue: [ self foo3 ]
]

{ #category : #tests }
MatchingRecentlyUsedTest >> foo2 [
	^ Set new
]

{ #category : #tests }
MatchingRecentlyUsedTest >> foo3 [
	^ OrderedCollection new
]

{ #category : #tests }
MatchingRecentlyUsedTest >> testFillUpGlobalsCache [

	| matcher |
	matcher := MatchingRecentlyUsed new.
	matcher fillCacheBasedOnCompiledMethod: (MatchingRecentlyUsedTest>> #foo).
	self assert: (matcher globalsIncludes: OrderedCollection).
]

{ #category : #tests }
MatchingRecentlyUsedTest >> testFillUpMessagesCache [

	| matcher |
	matcher := MatchingRecentlyUsed new.
	matcher fillCacheBasedOnCompiledMethod: (MatchingRecentlyUsedTest>> #foo).
	self assert: (matcher messagesIncludes: #isEmpty).
	self assert: (matcher messagesIncludes: #foo).
]
