formatting
format: anObject on: aStream

	anObject
		ifNotNil: [ (anObject isA: String)
				ifTrue: [ aStream nextPutAll: anObject ]
				ifFalse: [ aStream print: anObject ] ]