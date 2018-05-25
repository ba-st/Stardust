Class {
	#name : #NumberParserTests,
	#superclass : #TestCase,
	#category : 'Stardust-Tests-Parser'
}

{ #category : #tests }
NumberParserTests >> testParseInteger [

	| parser |

	parser := IntegerParser new.
	self assert: (parser parse: '12345') equals: 12345.
	self assert: (parser parse: '-123456') equals: -123456.
	self assert: (parser parse: '+123456') equals: 123456
]

{ #category : #tests }
NumberParserTests >> testParseIntegerFailsWhenNotANumber [

	| parser |

	parser := IntegerParser new.
	self
		should: [ parser parse: 'a' ]
		raise: ParsingFailed
		whoseDescriptionIncludes: 'First character of an integer is either a digit, + or -, not a'
		description: 'Parsing should fail when not a number'.
	self
		should: [ parser parse: '1a' ]
		raise: ParsingFailed
		whoseDescriptionIncludes: 'An integer only contains digits optionally prepended by + or -'
		description: 'Parsing should fail when not a number'.
	self
		should: [ parser parse: '1.3' ]
		raise: ParsingFailed
		whoseDescriptionIncludes: 'An integer only contains digits optionally prepended by + or -'
		description: 'Parsing should fail when not a number'
]

{ #category : #tests }
NumberParserTests >> testParseIntegerWithThousandSeparators [

	| parser |

	parser := IntegerParser withThousandsSeparator: $,.
	self assert: (parser parse: '12,345') equals: 12345.
	self assert: (parser parse: '-123,456') equals: -123456.
	self assert: (parser parse: '+1,234,567') equals: 1234567
]

{ #category : #tests }
NumberParserTests >> testParseNaturalNumber [

	| parser |

	parser := NaturalNumberParser new.
	self assert: (parser parse: '12345') equals: 12345.
	self assert: (parser parse: '123456') equals: 123456
]

{ #category : #tests }
NumberParserTests >> testParseNaturalNumberFailsWhenNotANumber [

	| parser |

	parser := NaturalNumberParser new.
	self
		should: [ parser parse: 'a' ]
		raise: ParsingFailed
		whoseDescriptionIncludes: 'An natural number only contains digits'
		description: 'Parsing should fail when not a number'.
	self
		should: [ parser parse: '1a' ]
		raise: ParsingFailed
		whoseDescriptionIncludes: 'An natural number only contains digits'
		description: 'Parsing should fail when not a number'.
	self
		should: [ parser parse: '1.3' ]
		raise: ParsingFailed
		whoseDescriptionIncludes: 'An natural number only contains digits'
		description: 'Parsing should fail when not a number'
]

{ #category : #tests }
NumberParserTests >> testParseNaturalNumberWithThousandSeparators [

	| parser |

	parser := NaturalNumberParser withThousandsSeparator: $,.
	self assert: (parser parse: '12,345') equals: 12345.
	self assert: (parser parse: '123,456') equals: 123456.
	self assert: (parser parse: '1,234,567') equals: 1234567
]

{ #category : #tests }
NumberParserTests >> testParseScaledDecimal [

	| parser |

	parser := ScaledDecimalParser decimalsSeparatedBy: $..
	self assert: (parser parse: '12345') equals: 12345.
	self assert: (parser parse: '-123456') equals: -123456.
	self assert: (parser parse: '+1234567') equals: 1234567.
	self assert: (parser parse: '12345.678') equals: 12345.678.
	self assert: (parser parse: '-123456.789') equals: -123456.789.
	self assert: (parser parse: '+1234567.89') equals: 1234567.89
]

{ #category : #tests }
NumberParserTests >> testParseScaledDecimalWithThousandSeparators [

	| parser |

	parser := ScaledDecimalParser decimalsSeparatedBy: $. thousandsSeparatedBy: $,.
	self assert: (parser parse: '12,345') equals: 12345.
	self assert: (parser parse: '-123,456') equals: -123456.
	self assert: (parser parse: '+1,234,567') equals: 1234567.
	self assert: (parser parse: '12,345.678') equals: 12345.678.
	self assert: (parser parse: '-123,456.789') equals: -123456.789.
	self assert: (parser parse: '+1,234,567.89') equals: 1234567.89
]

{ #category : #tests }
NumberParserTests >> testParseScaledDecimalWithThousandSeparatorsFailWhenNotANumber [

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
]
