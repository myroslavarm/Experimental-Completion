Class {
	#name : #CompletionContext,
	#superclass : #Object,
	#instVars : [
		'source',
		'position',
		'theClass',
		'completionToken',
		'model',
		'receiverClass',
		'controller',
		'ast',
		'node',
		'variables',
		'selectors'
	],
	#category : #'NewCompletion-Model'
}

{ #category : #'as yet unclassified' }
CompletionContext class >> controller: aNECController class: aClass source: aString position: anInteger [ 
	^ self new
		setController: aNECController
		class: aClass
		source: aString
		position: anInteger
]

{ #category : #accessing }
CompletionContext >> completionToken [
	"here we need to return the name of the var or selector"
	node := ast bestNodeFor: (position to: position).
	^node selector
]

{ #category : #action }
CompletionContext >> configureSelectorsAndVariables [
	variables := true.
	selectors := true.
	^true
]

{ #category : #accessing }
CompletionContext >> createModel [
	"to be implemented"
	self receiverClass
		ifNotNil: [^ NECTypedModel class: receiverClass].	
	^ NECUntypedModel
		class: theClass
		temporaries: (ast isMethod ifTrue: [ ast temporaryNames ] ifFalse: [ #() ])
		additionals: #()
		variables: false
		selectors: true
]

{ #category : #accessing }
CompletionContext >> model [
	model isNil ifTrue: [ model := self createModel ].
	^ model
]

{ #category : #action }
CompletionContext >> narrowWith: aString [ 
	completionToken := aString.
	model ifNotNil: [ model narrowWith: aString ].
	node := ast bestNodeFor: (position to: position).
]

{ #category : #parsing }
CompletionContext >> parseSource [
	(theClass = UndefinedObject) 
		ifTrue: [ ast :=  RBParser parseFaultyExpression: source ]
		ifFalse: [ ast := RBParser parseFaultyMethod: source ].
	ast doSemanticAnalysis.
	TypingVisitor new visitNode: ast.
]

{ #category : #accessing }
CompletionContext >> receiverClass [

	receiverClass := node receiver propertyAt: #type ifAbsent: [ nil ] .
	^ receiverClass 
]

{ #category : #'as yet unclassified' }
CompletionContext >> setController: aECController class: aClass source: aString position: anInteger [ 
	controller := aECController.
	theClass := aClass ifNil: [ UndefinedObject ].
	source := aString.
	position := anInteger. 
	self parseSource.
	node := ast bestNodeFor: (position to: position).
	
]
