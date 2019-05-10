Extension { #name : #NECContext }

{ #category : #'*NewCompletion' }
NECContext >> narrowWith: aString [
	"with every keystroke the list of suggested completions updates and gets more narrow"
	completionToken := aString.
	model ifNotNil: [ model narrowWith: aString ]
]
