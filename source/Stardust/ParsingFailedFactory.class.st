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

	^ DecodingFailed signal: aMessageText parsing: parsedString
]

{ #category : #signalling }
ParsingFailedFactory >> signalAll: failureExplanations [

	^ DecodingFailed signalAll: failureExplanations parsing: parsedString
]
