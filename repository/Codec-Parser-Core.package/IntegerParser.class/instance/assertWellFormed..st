private
assertWellFormed: aString

	AssertionCheckerBuilder new
		raising: (ParsingFailedFactory parsing: aString);
		checking: [ :mayBeEmpty | 
			mayBeEmpty
				refuse: [ aString isEmpty ]
				because: 'Empty string is not an integer'
				onSuccess: [ :asserter | 
					asserter
						enforce: [ aString first isDigit | (aString first = $+) | (aString first = $-) ]
						because: ('First character of an integer is either a digit, + or -, not <1s>' expandMacrosWith: aString first asString).
					thousandsSeparator
						withContentDo: [ :separator | 
							asserter
								enforce: [ self is: aString allButFirst separatedByThousandsWith: separator ]
								because: ('An integer only contains digits separated every third decimal place with: <1p> optionally prepended by + or -' expandMacrosWith: separator) ]
						ifUnused: [ asserter enforce: [ aString allButFirst allSatisfy: #isDigit ] because: 'An integer only contains digits optionally prepended by + or -' ] ] ];
		buildAndCheck