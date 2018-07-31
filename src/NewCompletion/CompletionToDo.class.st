Class {
	#name : #CompletionToDo,
	#superclass : #Object,
	#category : #NewCompletion
}

{ #category : #adding }
CompletionToDo >> addATest [

	'
	- add a tests showing that if a class and its subclass have instance variables starting with the same prefix
	we get in priority the closest one'
]

{ #category : #adding }
CompletionToDo >> addATestTempAndVariables [

	'
	add tests showing that 
		Object subclass: Foo
			instanceVarNames: ''tmp''
			
		
	| tmp1 |
	tmp
	
	the order should be tmp1 and tmp when the strategy is to sort closest first'
]

{ #category : #adding }
CompletionToDo >> addSomeNegativeTests [

	'for all the case but also for offset'
]

{ #category : #adding }
CompletionToDo >> addSortingOfTheResults [

	'
	Results should be sorted: and we probably need strategies to represent different sorting approaches'
]
