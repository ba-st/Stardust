Class {
	#name : #ISO8601Parser,
	#superclass : #Object,
	#category : 'Stardust-Parser'
}

{ #category : #parsing }
ISO8601Parser class >> acceptedFormats [

	self subclassResponsibility
]

{ #category : #'private-parsing' }
ISO8601Parser >> assertWellFormed: aString [

	AssertionChecker enforce: [ self class acceptedFormats anySatisfy: [ :pattern | pattern match: aString ] ] because: 'Must be in ISO-8601 format' raising: (ParsingFailedFactory parsing: aString)
]

{ #category : #parsing }
ISO8601Parser >> basicParse: aString [

	self subclassResponsibility
]

{ #category : #parsing }
ISO8601Parser >> parse: aString [

	self assertWellFormed: aString.
	^ self basicParse: aString readStream
]

{ #category : #'private-parsing' }
ISO8601Parser >> parseSignFrom: stream [

	^ stream peek isDigit
		ifTrue: [ 1 ]
		ifFalse: [ stream next = $-
				ifTrue: [ -1 ]
				ifFalse: [ 1 ] ]
]
