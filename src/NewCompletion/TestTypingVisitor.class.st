"
a test class
"
Class {
	#name : #TestTypingVisitor,
	#superclass : #TestCase,
	#category : #'NewCompletion-Typing'
}

{ #category : #tests }
TestTypingVisitor >> testGlobal [
	| ast node |

	ast := RBParser parseMethod: 'open Transcript test'.
	ast doSemanticAnalysis.

	TypingVisitor new visitNode: ast.
	self assert: ast variableNodes isNotEmpty.
	node := ast variableNodes first.
	self assert: (Smalltalk globals includes: (node propertyAt: #type) )
]

{ #category : #tests }
TestTypingVisitor >> testLiteral [
	| ast |

	ast := RBParser parseExpression: '1. #literal'.
	TypingVisitor new visitNode: ast.

	ast nodesDo: [ :each | each isLiteralNode ifTrue: 
			[ self assert: ((each propertyAt: #type) inheritsFrom: Object) ] ]
]

{ #category : #tests }
TestTypingVisitor >> testSelf [
	| ast node |

	ast := RBParser parseMethod: 'method self foo'.
	ast doSemanticAnalysis.

	TypingVisitor new visitNode: ast.
	self assert: ast variableNodes isNotEmpty.
	node := ast variableNodes first.
	self assert: (Smalltalk globals allClasses includes: (node propertyAt: #type) )
]

{ #category : #tests }
TestTypingVisitor >> testSuper [
	| ast node |

	ast := RBParser parseMethod: 'method super foo'.
	ast doSemanticAnalysis.

	TypingVisitor new visitNode: ast.
	self assert: ast variableNodes isNotEmpty.
	node := ast variableNodes first.
	self assert: ((node propertyAt: #type) isClass and:
			[ (node propertyAt: #type) = Object ] )
]
