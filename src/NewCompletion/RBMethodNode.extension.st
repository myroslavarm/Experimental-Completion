Extension { #name : #RBMethodNode }

{ #category : #'*NewCompletion' }
RBMethodNode >> completionToken [
	^ self selector asString
]

{ #category : #'*NewCompletion' }
RBMethodNode >> doSemanticAnalysisIn: behavior [
	self methodClass: behavior.
	self doSemanticAnalysis
]
