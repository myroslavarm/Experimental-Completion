"
A visitor that lets us know type of literals
"
Class {
	#name : #TypingVisitor,
	#superclass : #RBProgramNodeVisitor,
	#instVars : [
		'typeStack'
	],
	#category : #'NewCompletion-Typing'
}

{ #category : #visiting }
TypingVisitor >> initialize [

	typeStack := Stack new.
	typeStack push: Dictionary new.
]

{ #category : #visiting }
TypingVisitor >> visitAssignmentNode: anAssignmentNode [
	"add type of a variable to a dictionary with the key being the variable's name"
	
	| variableType |
	super visitAssignmentNode: anAssignmentNode.
	anAssignmentNode variable isTemp ifFalse: [ ^self ].
   (anAssignmentNode value hasProperty: #type) ifFalse: [ ^self ].
	variableType := anAssignmentNode value propertyAt: #type.
	typeStack top at: anAssignmentNode variable name put: variableType.
]

{ #category : #visiting }
TypingVisitor >> visitBlockNode: aBlockNode [
	| stackTop |
	typeStack push: typeStack top copy.
	super visitBlockNode: aBlockNode.
	stackTop := typeStack pop.
	stackTop keysDo: [ :name | 
			| type1 type2 |
			type2 := stackTop at: name.
			(typeStack top includesKey: name)
				ifFalse: [ typeStack top at: name put: type2 ]
				ifTrue: [ type1 := typeStack top at: name. 
					type1 == type2 ifFalse: [ typeStack top at: name put: (type2 commonSuperclass: type1) ] ] ].
	aBlockNode propertyAt: #type put: BlockClosure
]

{ #category : #visiting }
TypingVisitor >> visitGlobalNode: aGlobalNode [
	aGlobalNode propertyAt: #type put: (Smalltalk globals at: aGlobalNode name) class.
	"super visitVariableNode: aSelfNode"
]

{ #category : #visiting }
TypingVisitor >> visitLiteralNode: aLiteralNode [
	 aLiteralNode propertyAt: #type put: aLiteralNode value class
]

{ #category : #visiting }
TypingVisitor >> visitSelfNode: aSelfNode [
	 aSelfNode propertyAt: #type put: aSelfNode methodNode methodClass
]

{ #category : #visiting }
TypingVisitor >> visitSuperNode: aSuperNode [
	 aSuperNode propertyAt: #type put: aSuperNode methodNode methodClass superclass
]

{ #category : #visiting }
TypingVisitor >> visitTemporaryNode: aTemporaryNode [
	(typeStack top includesKey: aTemporaryNode name) ifFalse: [^self ].
	aTemporaryNode propertyAt: #type put: (typeStack top at: aTemporaryNode name)
]
