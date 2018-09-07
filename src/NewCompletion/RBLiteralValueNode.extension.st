Extension { #name : #RBLiteralValueNode }

{ #category : #'*NewCompletion' }
RBLiteralValueNode >> completionToken [
	^ self value asString
]
