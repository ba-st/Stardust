initialization
assertWellFormed: aString

	AssertionCheckerBuilder new
		raising: (ParsingFailedFactory parsing: aString);
		checking: [ :mayBeEmpty | 
			mayBeEmpty
				refuse: [ aString isEmpty ]
				because: 'Empty string is not an number'
				onSuccess: [ :asserter | 
					| substrings nonSignPart |

					self checkSignOf: aString using: asserter.
					nonSignPart := aString first isDigit
						ifFalse: [ aString allButFirst ]
						ifTrue: [ aString ].
					substrings := nonSignPart substrings: decimalSeparator asString.
					asserter
						enforce: [ (substrings size between: 1 and: 2) and: [ (aString count: [ :character | character = decimalSeparator ]) <= 1 ] ]
						because: ('A number can only have one decimal separator (<1s>) and must have an integer part' expandMacrosWith: decimalSeparator asString)
						onSuccess: [ :scaledDecimalAsserter | 
							substrings size = 2
								ifTrue: [ self checkDecimalPart: (substrings at: 2) using: scaledDecimalAsserter ]
								ifFalse:
									[ scaledDecimalAsserter refuse: [ aString last = decimalSeparator ] because: ('A number can not end with a decimal separator (<1s>)' expandMacrosWith: decimalSeparator asString) ].
							self checkIntegerPart: substrings first using: scaledDecimalAsserter ] ] ];
		buildAndCheck