tests-timestamp
testDateVariants

	| parser |

	parser := ISO8601DateParser new.

	self assert: (parser parse: '2007-04-05') equals: (Date year: 2007 month: 4 day: 5).
	self assert: (parser parse: '20070405') equals: (Date year: 2007 month: 4 day: 5).
	self assert: (parser parse: '+2007-04-05') equals: (Date year: 2007 month: 4 day: 5).
	self assert: (parser parse: '+20070405') equals: (Date year: 2007 month: 4 day: 5).
	self assert: (parser parse: '-2007-04-05') equals: (Date year: -2007 month: 04 day: 05).
	self assert: (parser parse: '-20070405') equals: (Date year: -2007 month: 04 day: 05)