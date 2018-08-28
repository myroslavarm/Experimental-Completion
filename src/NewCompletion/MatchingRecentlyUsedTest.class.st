"
A little test class for sorting
"
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
MatchingRecentlyUsedTest >> testEmptyUpGlobalsCache [

	| matcher |
	matcher := MatchingRecentlyUsed new.
	matcher fillCacheBasedOnCompiledMethod: (MatchingRecentlyUsedTest>> #foo).
	matcher emptyCacheBasedOnCompiledMethod: (MatchingRecentlyUsedTest>> #foo).
	self assert: matcher globalsIsEmpty equals: true.
]

{ #category : #tests }
MatchingRecentlyUsedTest >> testEmptyUpMessagesCache [

	| matcher |
	matcher := MatchingRecentlyUsed new.
	matcher fillCacheBasedOnCompiledMethod: (MatchingRecentlyUsedTest>> #foo).	
	matcher emptyCacheBasedOnCompiledMethod: (MatchingRecentlyUsedTest>> #foo).
	self assert: (matcher messagesIncludes: #isEmpty) equals: false.
	self assert: (matcher messagesIncludes: #foo) equals: false.
	self assert: matcher messagesIsEmpty equals: true.
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

{ #category : #tests }
MatchingRecentlyUsedTest >> testSortGlobals [

	| matcher |
	matcher := MatchingRecentlyUsed new.
	matcher fillCacheBasedOnCompiledMethod: (MatchingRecentlyUsedTest>> #foo).
	
	self assert: (matcher sortGlobals: {Object . OrderedCollection}) equals: { OrderedCollection . Object }
	
]

{ #category : #tests }
MatchingRecentlyUsedTest >> testSortMessages [

	| matcher |
	matcher := MatchingRecentlyUsed new.
	matcher fillCacheBasedOnCompiledMethod: (MatchingRecentlyUsedTest>> #foo).
	self assert: (matcher messagesIncludes: #isEmpty).
	self assert: (matcher messagesIncludes: #foo).
	
	self assert: (matcher sortMessages: #(#bar #isEmpty #foo)) equals: #(#foo #isEmpty #bar).
	
]
