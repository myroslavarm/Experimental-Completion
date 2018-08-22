"
A visitor that lets us know type of literals
"
Class {
	#name : #TypingVisitor,
	#superclass : #RBProgramNodeVisitor,
	#category : #'NewCompletion-Typing'
}

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
