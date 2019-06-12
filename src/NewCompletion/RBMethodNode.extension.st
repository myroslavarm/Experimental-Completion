Extension { #name : #RBMethodNode }

{ #category : #'*NewCompletion' }
RBMethodNode >> completionToken [
	^ ''
]

{ #category : #'*NewCompletion' }
RBMethodNode >> doSemanticAnalysisIn: behavior [
	self methodClass: behavior.
	self doSemanticAnalysis
]
