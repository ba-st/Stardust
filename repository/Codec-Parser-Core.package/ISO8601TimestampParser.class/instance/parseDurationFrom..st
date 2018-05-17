private-parsing
parseDurationFrom: stream

	| hour minute sign |

	sign := self parseSignFrom: stream.
	hour := sign * (stream next: 2) asNumber.
	minute := stream atEnd
		ifTrue: [ 0 ]
		ifFalse: [ stream peek = $:
				ifTrue: [ stream next ].
			(stream next: 2) asNumber ].
	self assertIsValidTime: stream contents withHour: hour minute: minute.
	^ Duration
		days: 0
		hours: hour
		minutes: minute
		seconds: 0