Extension { #name : #RBMethodNode }

{ #category : #'*NewCompletion' }
RBMethodNode >> completionToken [
	^ self selector asString
]
