test-time
testTimeVariants

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