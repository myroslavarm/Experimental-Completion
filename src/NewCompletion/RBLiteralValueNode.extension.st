Extension { #name : #RBLiteralValueNode }

{ #category : #'*NewCompletion' }
RBLiteralValueNode >> completionToken [
	^ self value asString
]

{ #category : #'*NewCompletion' }
RBLiteralValueNode >> narrowWith: aString [ 

	self flag: #maybeBug.
	"This seems to work because we only arrive here with Symbols.
	It may not work with other kind of literal values"
	value := aString asSymbol.
	sourceText := aString
]
