Extension { #name : #RBMethodNode }

{ #category : #'*NECompletion' }
RBMethodNode >> bestNodeFor: anInterval [ 

    ^self temporaries 
        detect:  [:each | 
            ((anInterval first between: each start and: each stop + 1) and: [anInterval last between: each start and: each stop + 1])] 
        ifNone: [super bestNodeFor: anInterval]
]

{ #category : #'*NECompletion' }
RBMethodNode >> signatureInterval [
    "return the interval of the method signature as parsed from the source"
    (self numArgs = 0) ifTrue: [ ^1 to: self keywordsIntervals first last  ].
    ^1 to: self arguments last stop
]
