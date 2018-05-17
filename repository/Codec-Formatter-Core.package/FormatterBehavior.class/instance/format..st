formatting
format: anObject

	^ String streamContents: [ :stream | self format: anObject on: stream ]