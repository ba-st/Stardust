parsing
parse: aString

	self assertWellFormed: aString.
	^ (thousandsSeparator withContentDo: [ :separator | aString copyWithout: separator ] ifUnused: [ aString ]) asNumber