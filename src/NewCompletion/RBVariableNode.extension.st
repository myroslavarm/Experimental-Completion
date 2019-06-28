Extension { #name : #RBVariableNode }

{ #category : #'*NewCompletion' }
RBVariableNode >> completionToken [

	^ self name
]

{ #category : #'*NewCompletion' }
RBVariableNode >> narrowWith: aString [ 

	self name: aString asSymbol
]
