tests
testParseIntegerWithThousandSeparators

	| parser |

	parser := IntegerParser withThousandsSeparator: $,.
	self assert: (parser parse: '12,345') equals: 12345.
	self assert: (parser parse: '-123,456') equals: -123456.
	self assert: (parser parse: '+1,234,567') equals: 1234567