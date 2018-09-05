"
A test class for the completion engine
"
Class {
	#name : #CompletionEngineTest,
	#superclass : #TestCase,
	#instVars : [
		'ast',
		'completer',
		'sorter',
		'globals',
		'messages'
	],
	#category : #'NewCompletion-Model'
}

{ #category : #setup }
CompletionEngineTest >> setUp [
	completer := CompletionEngine new.
	sorter := Sorter new.
	
	
]

{ #category : #'message sends' }
CompletionEngineTest >> testCompleteCascade [
	| result|
	result := completer complete: 'methodName 
					(1+2) 
						do: 1;
						wi'.
	self assert: (result includes: 'with:').
]

{ #category : #'class tests' }
CompletionEngineTest >> testCompleteClassName [
	| result|
	result := completer complete: 'methodName
	 Obje'.
	self assert: (result includes: 'Object').
	
]

{ #category : #'class tests' }
CompletionEngineTest >> testCompleteClassSideMethodNames [
	"CompletionMockClass is only supposed to give a suggestion for the class side method"
	| result|
	result := completer complete: 'methodName

	CompletionMockClass foo'.
	self assert: (result includes: #fooClass).
	
	result := completer complete: 'methodName

	CompletionMockSubclass foo'.
	self assert: (result includes: #fooClass).
	self assert: (result includes: #fooClassInSubclass).
	
]

{ #category : #'testing - variables' }
CompletionEngineTest >> testCompleteClassVariable [
	| result|
	result := completer complete: 'methodName
	 He' inClass: CompletionMockSubClass.
	self assert: (result includes: 'Hello').
	
]

{ #category : #'testing - variables' }
CompletionEngineTest >> testCompleteGlobalVariable [
	| result|
	result := completer complete: 'methodName
	 Tran'.
	self assert: (result includes: 'Transcript').
	
]

{ #category : #'testing - variables' }
CompletionEngineTest >> testCompleteInstanceVariable [
 
	| result |
	result := completer complete: 'dd myInstanceV' inClass: CompletionMockClass.
	self assert: (result includes: 'myInstanceVariable').
	
	
]

{ #category : #'testing - variables' }
CompletionEngineTest >> testCompleteInstanceVariableClassSide [
 
	| result |
	result := completer complete: 'methodName
		 noFi' inClass: OtherCompletionMockClass class.
	self assert: (result includes: 'noFilterMock').
	
	
]

{ #category : #'testing - variables' }
CompletionEngineTest >> testCompleteInstanceVariableInSubClass [
   
	| result |
	result := completer complete: 'methodNames
	 myInstance' inClass: CompletionMockSubClass.
	self assert: (result includes: 'myInstanceVariable').
	
	result := completer complete: 'methodNames
	 qwerIn' inClass: CompletionMockSubClass.
	self assert: (result isEmpty)
	
]

{ #category : #'message sends' }
CompletionEngineTest >> testCompleteMessage [
	| result|
	result := completer complete: 'methodName
	
	1 s'.
	self assert: (result includes: 'sin').

	
	
]

{ #category : #'message sends' }
CompletionEngineTest >> testCompleteMessageSendToSelf [
	"When we complete a message to self we should only consider the hierarchy"
	| result|
	result := completer complete: 'methodName
	
	self foo' inClass: CompletionMockSubClass.
	self deny: (result includes: 'fooo2').
	self assert: (result includes: 'foo1').
	self assert: (result includes: 'foo2').
	self assert: (result includes: 'fooo').
	
	
]

{ #category : #'message sends' }
CompletionEngineTest >> testCompleteMessageSendToSuper [
	"When we complete a message to super we should only consider the superclass"
	| result|
	result := completer complete: 'methodName
	
	super foo' inClass: CompletionMockSubClass.
	self deny: (result includes: 'foo2').
	self assert: (result includes: 'foo1').

	
	
]

{ #category : #'message sends' }
CompletionEngineTest >> testCompleteMessageWithParameter [
	"Like in the old system ifF gives all the options that begin with ifF without accounting for the ifTrue part."
	| result|
	result := completer complete: 'methodName
	
	true ifTrue: [1] ifN'.
	self assert: (result includes: 'ifNil:').

	
	
]

{ #category : #'message sends' }
CompletionEngineTest >> testCompleteMessageWithParameterOffset [
	| result a |
	result := completer complete: 'methodName
	
	a ifFal ifTrue:' offset: 21.
	self assert: (result includes: 'ifFalse:').

	
	
]

{ #category : #'message sends' }
CompletionEngineTest >> testCompleteMessageWithTypeInAssignment [
	| result|
	result := completer complete: 'methodName
	
	| t1 | t1 := 1. t1 ifT'.
	self assert: (result isEmpty).
	
	result := completer complete: 'methodName
	
	| t1 | t1 := 1. t1 si'.
	self assert: (result includes: 'sin').

	
	
]

{ #category : #'message sends' }
CompletionEngineTest >> testCompleteMessageWithTypeKnown [
	| result|
	result := completer complete: 'methodName
	
	1 ifT'.
	self assert: (result isEmpty).

	
	
]

{ #category : #'testing - variables' }
CompletionEngineTest >> testCompleteMethodArgument [
	"Complete an argument"
	| result|
	result := completer complete: 'methodName: aString 
			aS'.
	self assert: (result includes: 'aString').

	
	
]

{ #category : #'testing - variables' }
CompletionEngineTest >> testCompleteMethodArgumentDefinition [
	"Complete an argument"
	| result|
	result := completer complete: 'methodName: aS'.
	self assert: (result isEmpty).

	
	
]

{ #category : #'message sends' }
CompletionEngineTest >> testCompleteNoInstVarForSelf [
	"We shouldn't show an instance for a self call"
	| result|
	result := completer complete: 'methodName
	
	self tem' inClass: OtherCompletionMockClass.
	self assert: (result isEmpty)

	
	
]

{ #category : #'testing - variables' }
CompletionEngineTest >> testCompletePragma [
	| result|
	result := completer complete: 'methodName 
					<prag >' offset: 22.
	self assert: (result includes: 'pragma').
]

{ #category : #selectors }
CompletionEngineTest >> testCompleteSelector [
	| result|
	result := completer complete: 'methodName
	
	#bestNode'.
	self assert: (result includes: #bestNodeFor:).
	
]

{ #category : #selectors }
CompletionEngineTest >> testCompleteSelectorWithOffset [
	| result|
	result := completer complete: 'methodName
	
	#ifTrue . [1 + 2]' offset: 21.
	self assert: (result includes: #ifTrue:ifFalse:).
	
]

{ #category : #'testing - variables' }
CompletionEngineTest >> testCompleteSharedPoolVariable [
	| result|
	result := completer complete: 'methodName
	 Re' inClass: CompletionMockClass.
	self assert: (result includes: 'Reverse')
	
]

{ #category : #selectors }
CompletionEngineTest >> testCompleteSymbol [
	| result|
	result := completer complete: 'methodName 
				#symbo'.
	self assert: (result includes: #symbol).
]

{ #category : #selectors }
CompletionEngineTest >> testCompleteSymbolInArray [
	| result|
	self flag: 'maybe parantheses support should be added'.
	result := completer complete: 'methodName 
				#(#tes)' offset: 22.
	self assert: (result includes: #test).
]

{ #category : #'testing - variables' }
CompletionEngineTest >> testCompleteVariableDefinition [
	"We never complete definitions"
	| result |
	result := completer complete: 'methodName
	|myTemp aVariable aV| 
	a := my' offset: 32.
	self assert: result isEmpty.
	
]

{ #category : #'testing - variables' }
CompletionEngineTest >> testCompleteVariableTemp [
	| result |
	result := completer complete: 'methodName

	 	|myTemp| 
		my'.
	self assert: (result includes: 'myTemp').
	
	
	
]

{ #category : #'testing - variables' }
CompletionEngineTest >> testCompleteVariableTempInAssignment [
	| result|
	result := completer complete: 'methodName 
	
	|myTemp aa | 
	aa := myT'.
	self assert: (result includes: 'myTemp').
	
	
	
]

{ #category : #'testing - variables' }
CompletionEngineTest >> testCompleteVariableTempMiddle [
	"The completion should work if the user places its cursor in the middle of an expression.
	Here the cursor is after the a in the a := my"
	| result |
	result := completer complete: 'methodName
	|myTemp aVariable | 
	a := my' offset: 35.
	self assert: (result includes: 'aVariable').
	
]

{ #category : #'testing syntax' }
CompletionEngineTest >> testCompleteWithIncompleteSyntaxAtBeginning [
	| result|
	self skip: 'this is a problem that we should solve later'.
	"the error node has wrong start and stop and no content."
	result := completer complete: 'methodName
        ( 1 do'.
	self assert: (result includes: 'do:without:').
	
]

{ #category : #'testing syntax' }
CompletionEngineTest >> testCompleteWithWrongSyntaxAtBeginning [
	| result|
	"Like in the old one, we don't complete anything if there's a syntax error."
	result := completer complete: 'methodName
        ) self hal'.
	self assert: (result isEmpty).
]

{ #category : #'testing syntax' }
CompletionEngineTest >> testCompleteWithWrongSyntaxAtEnd [
	| result|
	result := completer complete: 'methodName
        self hal )' offset: 27.
	self assert: (result includes: 'halt').
	
]

{ #category : #'tests - sorting' }
CompletionEngineTest >> testSortAlphabetically [
	"When we complete a message to self we should only consider the hierarchy"
	| result|
	result := completer complete: 'methodName
	
	self foo' inClass: CompletionMockSubClass.
	completer sorter: AlphabeticSorter new.
	result := completer sortList: result.
	self assert: (result first = 'foo1').
	self assert: (result includes: 'foo2').
	self assert: (result includes: 'fooo').
	
	
]

{ #category : #'tests - sorting' }
CompletionEngineTest >> testSortInReverseOrder [
	"Sorted and then reversed"
	| result|
	result := completer complete: 'methodName
	
	self foo' inClass: CompletionMockSubClass.
	completer sorter: ReverseSorter new.
	result := completer sortList: result.
	self assert: (result first = 'fooo').
	self assert: (result includes: 'foo2').
	self assert: (result last = 'foo1').
	
	
]

{ #category : #'tests - sorting' }
CompletionEngineTest >> testSortUsed [
	| result matcher |
	result := completer complete: 'methodName
	
	(1+2) foo'.
	matcher := MatchingRecentlyUsed new.
	matcher fillCacheBasedOnCompiledMethod: (MatchingRecentlyUsedTest>> #foo).
	completer sorter: (RecentSorter new matcher: matcher).
	result := completer sortList: result.
	self assert: (result includes: 'fooo').
	self assert: result third equals: 'foo2'.
	self assert: result first equals: 'foo'.
	
	
]
