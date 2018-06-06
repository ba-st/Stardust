Class {
	#name : #DecodingFailed,
	#superclass : #Error,
	#instVars : [
		'failures'
	],
	#category : #'Stardust-ModelCreation'
}

{ #category : #signalling }
DecodingFailed class >> signal: failureExplanation parsing: aString [

	^ self signalAll: (Array with: failureExplanation) parsing: aString
]

{ #category : #signalling }
DecodingFailed class >> signalAll: failureExplanations parsing: aString [

	^ (self new initializeParsing: aString explainedByAll: failureExplanations) signal: ('. ' join: failureExplanations)
]

{ #category : #initialization }
DecodingFailed >> failures [

	^ failures
]

{ #category : #initialization }
DecodingFailed >> initializeParsing: aString explainedByAll: failureExplanations [

	self tag: aString.
	failures := failureExplanations.
]
