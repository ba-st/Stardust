private
basicParse: stream

	| hour minute second nanoSecond |

	hour := (stream next: 2) asNumber.
	stream peek = $:
		ifTrue: [ stream next ].
	minute := (stream next: 2) asNumber.
	stream peek = $:
		ifTrue: [ stream next ].
	stream atEnd
		ifTrue: [ second := nanoSecond := 0 ]
		ifFalse: [ second := (stream next: 2) asNumber.
			nanoSecond := stream peek = $.
				ifTrue: [ stream next.
					(stream upToEnd padRightTo: 9 with: $0) asNumber ]
				ifFalse: [ 0 ] ].
	self
		assertIsValidTime: stream contents
		withHour: hour
		minute: minute
		second: second
		nanoSecond: nanoSecond.
	^ Time
		hour: hour
		minute: minute
		second: second
		nanoSecond: nanoSecond