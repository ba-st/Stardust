private-parsing
parseSignFrom: stream

	^ stream peek isDigit
		ifTrue: [ 1 ]
		ifFalse: [ stream next = $-
				ifTrue: [ -1 ]
				ifFalse: [ 1 ] ]