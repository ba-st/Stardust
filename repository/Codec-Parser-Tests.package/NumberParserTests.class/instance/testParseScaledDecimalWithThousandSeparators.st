tests
testParseScaledDecimalWithThousandSeparators

	| parser |

	parser := ScaledDecimalParser decimalsSeparatedBy: $. thousandsSeparatedBy: $,.
	self assert: (parser parse: '12,345') equals: 12345.
	self assert: (parser parse: '-123,456') equals: -123456.
	self assert: (parser parse: '+1,234,567') equals: 1234567.
	self assert: (parser parse: '12,345.678') equals: 12345.678.
	self assert: (parser parse: '-123,456.789') equals: -123456.789.
	self assert: (parser parse: '+1,234,567.89') equals: 1234567.89