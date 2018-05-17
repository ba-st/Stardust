tests
testParseInteger

	| parser |

	parser := IntegerParser new.
	self assert: (parser parse: '12345') equals: 12345.
	self assert: (parser parse: '-123456') equals: -123456.
	self assert: (parser parse: '+123456') equals: 123456