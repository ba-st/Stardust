private-parsing
assertWellFormed: aString

	AssertionChecker enforce: [ self class acceptedFormats anySatisfy: [ :pattern | pattern match: aString ] ] because: 'Must be in ISO-8601 format' raising: (ParsingFailedFactory parsing: aString)