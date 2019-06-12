Class {
	#name : #BaselineOfExperimentalCompletion,
	#superclass : #BaselineOf,
	#category : #BaselineOfExperimentalCompletion
}

{ #category : #baselines }
BaselineOfExperimentalCompletion >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [
			"Packages"
			spec
				package: 'NECompletion';
				package: 'NECompletion-Tests';
				package: 'NewCompletion';
				package: 'NewCompletionSpec' ]
]

{ #category : #baselines }
BaselineOfExperimentalCompletion >> projectClass [
	^ MetacelloCypressBaselineProject
]
