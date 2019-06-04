Extension { #name : #RBMethodNode }

{ #category : #'*NewCompletion' }
RBMethodNode >> completionToken [
	^ self selector asString
]

{ #category : #'*NewCompletion' }
RBMethodNode >> doSemanticAnalysisIn: behavior [
    behavior ifNotNil: [self methodClass: behavior].
    self doSemanticAnalysis
]
