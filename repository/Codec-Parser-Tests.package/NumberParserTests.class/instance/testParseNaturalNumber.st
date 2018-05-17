tests
testParseNaturalNumber

	| parser |

	parser := NaturalNumberParser new.
	self assert: (parser parse: '12345') equals: 12345.
	self assert: (parser parse: '123456') equals: 123456