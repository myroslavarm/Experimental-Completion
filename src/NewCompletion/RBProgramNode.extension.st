Extension { #name : #RBProgramNode }

{ #category : #'*NewCompletion' }
RBProgramNode >> narrowWith: aString [ 

	"Do nothing"
]

{ #category : #'*NewCompletion' }
RBProgramNode >> typeForCompletionIfAbsent: aBlock [

	^ self propertyAt: #type ifAbsent: [ ^ aBlock value ]
]
