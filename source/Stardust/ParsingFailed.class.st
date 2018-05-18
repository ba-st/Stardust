Class {
	#name : #ParsingFailed,
	#superclass : #Error,
	#instVars : [
		'failures'
	],
	#category : 'Stardust-Parser'
}

{ #category : #signalling }
ParsingFailed class >> signal: failureExplanation parsing: aString [

	^ self signalAll: (Array with: failureExplanation) parsing: aString
]

{ #category : #signalling }
ParsingFailed class >> signalAll: failureExplanations parsing: aString [

	^ (self new initializeParsing: aString explainedByAll: failureExplanations) signal: ('. ' join: failureExplanations)
]

{ #category : #initialization }
ParsingFailed >> failures [

	^ failures
]

{ #category : #initialization }
ParsingFailed >> initializeParsing: aString explainedByAll: failureExplanations [

	self tag: aString.
	failures := failureExplanations.
]
