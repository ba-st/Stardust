tests-timestamp
testUTCTimeWithMillisecondsVariants

	| expectedDateAndTime parser |

	parser := ISO8601TimestampParser new.
	expectedDateAndTime := DateAndTime
		year: 2007
		month: 04
		day: 05
		hour: 14
		minute: 30
		second: 0
		nanoSecond: (Duration milliSeconds: 300) asNanoSeconds
		offset: Duration zero.
	self assert: (parser parse: '2007-04-05T14:30:00.300Z') equals: expectedDateAndTime.
	self assert: (parser parse: '2007-04-05T14:30:00.30Z') equals: expectedDateAndTime.
	self assert: (parser parse: '2007-04-05T14:30:00.3Z') equals: expectedDateAndTime