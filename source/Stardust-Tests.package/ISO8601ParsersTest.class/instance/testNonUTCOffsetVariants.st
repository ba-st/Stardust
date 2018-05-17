tests-timestamp
testNonUTCOffsetVariants

	| expectedDateAndTime parser |

	parser := ISO8601TimestampParser new.
	expectedDateAndTime := DateAndTime
		year: 2007
		month: 04
		day: 05
		hour: 14
		minute: 30
		second: 0
		offset: (Duration hours: -3).
	self
		assert: (parser parse: '2007-04-05T14:30:00-03:00') equals: expectedDateAndTime;
		assert: (parser parse: '2007-04-05T14:30:00-0300') equals: expectedDateAndTime;
		assert: (parser parse: '2007-04-05T14:30:00-03') equals: expectedDateAndTime.
	expectedDateAndTime := DateAndTime
		year: 2007
		month: 04
		day: 05
		hour: 14
		minute: 30
		second: 0
		offset:
			(Duration
				days: 0
				hours: 5
				minutes: 45
				seconds: 0).
	self assert: (parser parse: '2007-04-05T14:30:00+05:45') equals: expectedDateAndTime.
	self assert: (parser parse: '2007-04-05T14:30:00+0545') equals: expectedDateAndTime.
	expectedDateAndTime := DateAndTime
		year: 2007
		month: 04
		day: 05
		hour: 14
		minute: 30
		second: 0
		offset: (Duration hours: 5).
	self assert: (parser parse: '2007-04-05T14:30:00+05') equals: expectedDateAndTime