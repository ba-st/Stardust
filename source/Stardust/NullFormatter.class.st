Class {
	#name : #NullFormatter,
	#superclass : #FormatterBehavior,
	#category : 'Stardust-Formatter'
}

{ #category : #formatting }
NullFormatter >> format: anObject on: aStream [

	anObject
		ifNotNil: [ (anObject isA: String)
				ifTrue: [ aStream nextPutAll: anObject ]
				ifFalse: [ aStream print: anObject ] ]
]
