tests
testParseIntegerFailsWhenNotANumber

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