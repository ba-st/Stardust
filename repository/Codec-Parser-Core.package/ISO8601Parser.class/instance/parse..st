parsing
parse: aString

	self assertWellFormed: aString.
	^ self basicParse: aString readStream