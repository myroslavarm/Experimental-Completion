"
I am a context class that hooks the new completion functionality into the system. To do that, i reimplement some of the methods but use most of the old ones from NECompletion package, such as the functionality to call the menu, etc.
"
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
		'selectors',
		'context'
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
	node isNil ifTrue: [ ^ '' ].
	^completionToken
		ifNil: [ node completionToken ]
]

{ #category : #action }
CompletionContext >> configureSelectorsAndVariables [
	variables := true.
	selectors := true.
	^true
]

{ #category : #accessing }
CompletionContext >> context: aCompletionContext [
	context := aCompletionContext.
]

{ #category : #accessing }
CompletionContext >> createModel [
	"to be implemented"
	node isNil ifTrue: [ ^NECEmptyModel new ].
	node isLiteralNode ifTrue: [ ^NECEmptyModel new ].
	node isMethod ifTrue: [ ^NECEmptyModel new ].
	self receiverClass
		ifNotNil: [^ NECTypedModel class: receiverClass].
	variables := false. selectors  := true.
	node isMessage ifFalse: [  variables := true. selectors  := true ].
	"self context: model."
	^ NECUntypedModel
		class: theClass
		temporaries: (ast isMethod ifTrue: [ ast temporaryNames ] ifFalse: [ #() ])
		additionals: #()
		variables: variables
		selectors: selectors
]

{ #category : #accessing }
CompletionContext >> model [
	model isNil ifTrue: [ model := self createModel ].
	^ model
]

{ #category : #action }
CompletionContext >> narrowWith: aString [
	"method borrowed from NECContext to make the completion plugging work"
	completionToken := aString.
	model ifNotNil: [ model narrowWith: aString].
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
	node isMessage ifFalse: [ ^nil ].
	receiverClass := node receiver propertyAt: #type ifAbsent: [ nil ] .
	^ receiverClass
]

{ #category : #'initialize-release' }
CompletionContext >> setController: aECController class: aClass source: aString position: anInteger [ 
	controller := aECController.
	theClass := aClass ifNil: [ UndefinedObject ].
	source := aString.
	position := anInteger. 
	self parseSource.
	node := ast bestNodeFor: (position to: position).
	
]
