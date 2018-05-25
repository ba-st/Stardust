Class {
	#name : #ISO8601DateFormatter,
	#superclass : #FormatterBehavior,
	#category : #'Stardust-Formatter'
}

{ #category : #formatting }
ISO8601DateFormatter >> format: aDate on: aStream [

	aStream
		nextPutAll: (aDate year printPaddedWith: $0 to: 4);
		nextPut: $-;
		nextPutAll: (aDate monthIndex printPaddedWith: $0 to: 2);
		nextPut: $-;
		nextPutAll: (aDate dayOfMonth printPaddedWith: $0 to: 2)
]