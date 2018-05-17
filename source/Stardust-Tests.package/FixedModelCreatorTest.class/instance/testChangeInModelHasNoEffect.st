tests
testChangeInModelHasNoEffect

	| creator |

	creator := FixedModelCreator creating: (Percentage of: 30).
	creator changeModelTo: (Percentage of: 55) in: self.
	self assert: (creator modelIn: self) equals: (Percentage of: 30)