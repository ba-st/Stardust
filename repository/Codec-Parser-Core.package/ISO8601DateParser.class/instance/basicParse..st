parsing
basicParse: stream

	| sign year monthIndex dayOfMonth |

	sign := self parseSignFrom: stream.
	year := (stream next: 4) asNumber * sign.
	stream peek = $-
		ifTrue: [ stream next ].
	monthIndex := (stream next: 2) asNumber.
	stream peek = $-
		ifTrue: [ stream next ].
	dayOfMonth := stream upToEnd asNumber.
	self
		assertIsValidDate: stream contents
		withYear: year
		month: monthIndex
		day: dayOfMonth.
	^ Date year: year month: monthIndex day: dayOfMonth