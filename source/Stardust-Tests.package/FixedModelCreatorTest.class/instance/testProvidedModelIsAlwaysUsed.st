tests
testProvidedModelIsAlwaysUsed

	| creator |

	creator := FixedModelCreator creating: (Percentage of: 30).
	self assert: (creator modelIn: self) equals: (Percentage of: 30)