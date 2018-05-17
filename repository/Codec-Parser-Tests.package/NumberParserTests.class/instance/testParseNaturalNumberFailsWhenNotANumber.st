tests
testParseNaturalNumberFailsWhenNotANumber

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