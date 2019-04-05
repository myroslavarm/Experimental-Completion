Extension { #name : #Class }

{ #category : #'*NewCompletion' }
Class >> commonSuperclass: aClass [

	^ self allSuperclasses detect: [ :class | (aClass allSuperclasses includes: class) ]

	
]
