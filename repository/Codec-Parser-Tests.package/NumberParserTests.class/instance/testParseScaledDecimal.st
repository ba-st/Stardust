tests
testParseScaledDecimal

	| parser |

	parser := ScaledDecimalParser decimalsSeparatedBy: $..
	self assert: (parser parse: '12345') equals: 12345.
	self assert: (parser parse: '-123456') equals: -123456.
	self assert: (parser parse: '+1234567') equals: 1234567.
	self assert: (parser parse: '12345.678') equals: 12345.678.
	self assert: (parser parse: '-123456.789') equals: -123456.789.
	self assert: (parser parse: '+1234567.89') equals: 1234567.89