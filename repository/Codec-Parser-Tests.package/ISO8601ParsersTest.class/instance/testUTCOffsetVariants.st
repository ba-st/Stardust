tests-timestamp
testUTCOffsetVariants

	| expectedDateAndTime parser |

	parser := ISO8601TimestampParser new.
	expectedDateAndTime := DateAndTime
		year: 2007
		month: 04
		day: 05
		hour: 14
		minute: 30
		second: 0
		offset: Duration zero.
	self
		assert: (parser parse: '2007-04-05T14:30:00Z') equals: expectedDateAndTime;
		assert: (parser parse: '2007-04-05T14:30:00+00:00') equals: expectedDateAndTime;
		assert: (parser parse: '2007-04-05T14:30:00-00:00') equals: expectedDateAndTime;
		assert: (parser parse: '2007-04-05T14:30:00+0000') equals: expectedDateAndTime;
		assert: (parser parse: '2007-04-05T14:30:00-0000') equals: expectedDateAndTime;
		assert: (parser parse: '2007-04-05T14:30:00+00') equals: expectedDateAndTime;
		assert: (parser parse: '2007-04-05T14:30:00-00') equals: expectedDateAndTime