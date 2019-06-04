Extension { #name : #RBProgramNode }

{ #category : #'*NewCompletion' }
RBProgramNode >> doSemanticAnalysisIn: aClass [
    self methodNode ifNil: [ ^self ].
    ^ self methodNode doSemanticAnalysisIn: aClass
]
