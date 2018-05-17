private-parsing
parseOffsetFrom: gmtOffsetString

	^ gmtOffsetString = 'Z'
		ifTrue: [ Duration zero ]
		ifFalse: [ self parseDurationFrom: gmtOffsetString readStream ]