Class {
	#name : #ISO8601ParsersTest,
	#superclass : #TestCase,
	#category : 'Stardust-Tests-Parser'
}

{ #category : #'tests-timestamp' }
ISO8601ParsersTest >> testDateVariants [

	| parser |

	parser := ISO8601DateParser new.

	self assert: (parser parse: '2007-04-05') equals: (Date year: 2007 month: 4 day: 5).
	self assert: (parser parse: '20070405') equals: (Date year: 2007 month: 4 day: 5).
	self assert: (parser parse: '+2007-04-05') equals: (Date year: 2007 month: 4 day: 5).
	self assert: (parser parse: '+20070405') equals: (Date year: 2007 month: 4 day: 5).
	self assert: (parser parse: '-2007-04-05') equals: (Date year: -2007 month: 04 day: 05).
	self assert: (parser parse: '-20070405') equals: (Date year: -2007 month: 04 day: 05)
]

{ #category : #'tests-timestamp' }
ISO8601ParsersTest >> testNonUTCOffsetVariants [

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
]

{ #category : #'test-time' }
ISO8601ParsersTest >> testTimeVariants [

	| expectedDateAndTime parser |

	parser := ISO8601TimeParser new.
	expectedDateAndTime := Time hour: 14 minute: 30 second: 0.
	self assert: (parser parse: '14:30') equals: expectedDateAndTime.
	self assert: (parser parse: '1430') equals: expectedDateAndTime.
	self assert: (parser parse: '14:30:00') equals: expectedDateAndTime.
	self assert: (parser parse: '143000') equals: expectedDateAndTime.
	self assert: (parser parse: '14:30:00.000') equals: expectedDateAndTime.
	self assert: (parser parse: '143000.000') equals: expectedDateAndTime.
	self
		assert: (parser parse: '14:30:00.300')
		equals:
			(Time
				hour: 14
				minute: 30
				second: 0
				nanoSecond: 300000000).
	self
		assert: (parser parse: '143000.300')
		equals:
			(Time
				hour: 14
				minute: 30
				second: 0
				nanoSecond: 300000000)
]

{ #category : #'tests-timestamp' }
ISO8601ParsersTest >> testUTCDateVariants [

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
	self assert: (parser parse: '2007-04-05T14:30Z') equals: expectedDateAndTime.
	self assert: (parser parse: '+2007-04-05T14:30Z') equals: expectedDateAndTime.
	self
		assert: (parser parse: '-2007-04-05T14:30Z')
		equals:
			(DateAndTime
				year: -2007
				month: 04
				day: 05
				hour: 14
				minute: 30
				second: 0
				offset: Duration zero)
]

{ #category : #'tests-timestamp' }
ISO8601ParsersTest >> testUTCOffsetVariants [

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
]

{ #category : #'tests-timestamp' }
ISO8601ParsersTest >> testUTCTimeVariants [

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
	self assert: (parser parse: '2007-04-05T14:30Z') equals: expectedDateAndTime.
	self assert: (parser parse: '2007-04-05T14:30:00Z') equals: expectedDateAndTime.
	self assert: (parser parse: '2007-04-05T14:30:00.000Z') equals: expectedDateAndTime
]

{ #category : #'tests-timestamp' }
ISO8601ParsersTest >> testUTCTimeWithMillisecondsVariants [

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
]
