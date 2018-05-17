initialization
checkSignOf: aString using: asserter

	asserter
		enforce:
			[ aString first isDigit | (aString first = $+) | (aString first = $-) ]
		because:
			('First character of an number is either a digit, + or -, not <1s>'
				expandMacrosWith: aString first asString)