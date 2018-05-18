Class {
	#name : #ParsingFailedFactory,
	#superclass : #Object,
	#instVars : [
		'parsedString'
	],
	#category : #'Stardust-Parser'
}

{ #category : #'instance creation' }
ParsingFailedFactory class >> parsing: aString [

	^ self new initializeParsing: aString
]

{ #category : #initialization }
ParsingFailedFactory >> initializeParsing: aString [

	parsedString := aString
]

{ #category : #signalling }
ParsingFailedFactory >> signal: aMessageText [

	^ ParsingFailed signal: aMessageText parsing: parsedString
]

{ #category : #signalling }
ParsingFailedFactory >> signalAll: failureExplanations [

	^ ParsingFailed signalAll: failureExplanations parsing: parsedString
]
