initialization
checkIntegerPart: integerPart using: mayBeEmpty

	^ mayBeEmpty
		refuse: [ integerPart isEmpty ]
		because: 'Integer part can not be empty'
		onSuccess: [ :asserter | 
			thousandsSeparator
				withContentDo: [ :separator | 
					asserter
						enforce: [ self is: integerPart separatedByThousandsWith: separator ]
						because:
							('A number has an integer part with digits separated every third decimal place with: <1p> optionally prepended by + or -'
								expandMacrosWith: separator) ]
				ifUnused: [ asserter
						enforce: [ integerPart allSatisfy: #isDigit ]
						because: 'A number has an integer part with digits optionally prepended by + or -' ] ]