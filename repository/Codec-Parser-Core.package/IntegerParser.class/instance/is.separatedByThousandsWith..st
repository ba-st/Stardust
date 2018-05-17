private
is: aNumberString separatedByThousandsWith: separator

	"Backwards (in ascending significance), every 4th must be the separator, all the others must be digits"

	| reversedNumber |

	reversedNumber := aNumberString reversed.
	^ reversedNumber
		allSatisfy: [ :c | 
			(reversedNumber indexOf: c) \\ 4 = 0
				ifTrue: [ c = separator ]
				ifFalse: [ c isDigit ] ]