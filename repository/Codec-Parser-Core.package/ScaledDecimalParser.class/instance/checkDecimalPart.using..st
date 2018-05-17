initialization
checkDecimalPart: decimalPart using: scaledDecimalAsserter

	scaledDecimalAsserter
		enforce: [ decimalPart allSatisfy: #isDigit ]
		because: 'A number has decimal / fractional part with digits'