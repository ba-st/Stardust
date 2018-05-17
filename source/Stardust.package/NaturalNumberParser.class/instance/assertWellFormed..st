parsing
assertWellFormed: aString

	AssertionCheckerBuilder new
		raising: (ParsingFailedFactory parsing: aString);
		checking: [ :mayBeEmpty | 
			mayBeEmpty
				refuse: [ aString isEmpty ]
				because: 'Empty string is not a natural number'
				onSuccess: [ :asserter | 
					thousandsSeparator
						withContentDo:
							[ :separator | asserter enforce: [ self is: aString separatedByThousandsWith: separator ] because: ('An natural number only contains digits separated every third decimal place with: <1p>' expandMacrosWith: separator) ]
						ifUnused: [ asserter enforce: [ aString allSatisfy: #isDigit ] because: 'An natural number only contains digits' ] ] ];
		buildAndCheck