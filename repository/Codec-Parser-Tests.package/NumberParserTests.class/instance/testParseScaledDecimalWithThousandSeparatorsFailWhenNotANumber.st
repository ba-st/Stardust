tests
testParseScaledDecimalWithThousandSeparatorsFailWhenNotANumber

	| parser |

	parser := ScaledDecimalParser decimalsSeparatedBy: $. thousandsSeparatedBy: $,.
	self should: [ parser parse: ',' ] raise: ParsingFailed.
	self should: [ parser parse: '.' ] raise: ParsingFailed.
	self should: [ parser parse: '123,456,789.' ] raise: ParsingFailed.
	self should: [ parser parse: '123,456,.1' ] raise: ParsingFailed.
	self should: [ parser parse: '123.456.789' ] raise: ParsingFailed.
	self should: [ parser parse: '123,,456.789' ] raise: ParsingFailed.
	self should: [ parser parse: '123,456..789' ] raise: ParsingFailed.
	self should: [ parser parse: '123456,789' ] raise: ParsingFailed.
	self should: [ parser parse: '123.456,789' ] raise: ParsingFailed