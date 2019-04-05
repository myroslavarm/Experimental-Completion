"
A test class for testing the typing visitor
"
Class {
	#name : #TestTypingVisitor,
	#superclass : #TestCase,
	#category : #'NewCompletion-Typing'
}

{ #category : #tests }
TestTypingVisitor >> testAssignment [
	| ast node |

	ast := RBParser parseMethod: 'method
		| t1 |
		t1 := 1.
		t1 sin'.
	ast doSemanticAnalysis.
	TypingVisitor new visitNode: ast.
	self assert: ast variableNodes isNotEmpty.
	node := ast variableNodes second.
	self assert: (node propertyAt: #type) equals: SmallInteger.
]

{ #category : #tests }
TestTypingVisitor >> testBlock [
	| ast node |

	ast := RBParser parseMethod: 'method
			| t1 t2|
			t1 := 1.
			1 ifTrue: [ t1 := 3.5. t2 := 1 ].
			t1 sin'.
	ast doSemanticAnalysis.

	TypingVisitor new visitNode: ast.
	self assert: ast variableNodes isNotEmpty.
	node := ast variableNodes fourth.
	self assert: ((node propertyAt: #type) isClass and:
			[ (node propertyAt: #type) = Number ] )
]

{ #category : #tests }
TestTypingVisitor >> testBlockSameType [
	| ast node |

	ast := RBParser parseMethod: 'method
			| t1 t2|
			t1 := 1.
			1 ifTrue: [ t1 := 2. t2 := 1 ].
			t1 sin'.
	ast doSemanticAnalysis.

	TypingVisitor new visitNode: ast.
	self assert: ast variableNodes isNotEmpty.
	node := ast variableNodes fourth.
	self assert: ((node propertyAt: #type) isClass and:
			[ (node propertyAt: #type) = SmallInteger ] )
]

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
