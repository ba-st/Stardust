initialization
is: aNumberString separatedByThousandsWith: separator

	"Backwards (in ascending significance), every 4th must be the separator, all the others must be digits"

	| reversedNumber |

	reversedNumber := aNumberString reversed.
	reversedNumber
		doWithIndex: [ :character :index | 
			index \\ 4 = 0
				ifTrue: [ character = separator
						ifFalse: [ ^ false ] ]
				ifFalse: [ character isDigit
						ifFalse: [ ^ false ] ] ].
	^ true