Extension { #name : #RBMessageNode }

{ #category : #'*NewCompletion' }
RBMessageNode >> completionToken [

	^ self selector
]

{ #category : #'*NewCompletion' }
RBMessageNode >> narrowWith: aString [

 	self selector: aString asSymbol
]

{ #category : #'*NewCompletion' }
RBMessageNode >> typeForCompletionIfAbsent: aBlock [

 	^ self receiver typeForCompletionIfAbsent: aBlock
]
