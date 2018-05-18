Class {
	#name : #FormatterBehavior,
	#superclass : #Object,
	#category : 'Stardust-Formatter'
}

{ #category : #formatting }
FormatterBehavior >> format: anObject [

	^ String streamContents: [ :stream | self format: anObject on: stream ]
]

{ #category : #formatting }
FormatterBehavior >> format: anObject on: aStream [

	self subclassResponsibility
]
