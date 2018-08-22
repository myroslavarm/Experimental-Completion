"
A visitor that lets us know type of literals
"
Class {
	#name : #TypingVisitor,
	#superclass : #RBProgramNodeVisitor,
	#instVars : [
		'typeDict'
	],
	#category : #'NewCompletion-Typing'
}

{ #category : #visiting }
TypingVisitor >> initialize [

	typeDict := Dictionary new.
]

{ #category : #visiting }
TypingVisitor >> visitAssignmentNode: anAssignmentNode [
	
	| variableType |
	super visitAssignmentNode: anAssignmentNode.
	anAssignmentNode variable isTemp ifFalse: [^self ].
   (anAssignmentNode value hasProperty: #type) ifFalse: [^self ].
	variableType := anAssignmentNode value propertyAt: #type.
	typeDict at: anAssignmentNode variable name put: variableType.
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
	(typeDict includesKey: aTemporaryNode name) ifFalse: [^self ].
	aTemporaryNode propertyAt: #type put: (typeDict at: aTemporaryNode name)
]
