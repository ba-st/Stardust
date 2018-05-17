tests
testChangingModelToValidOption

	| creator |

	creator := ModelMultiplexer
		multiplexing:
			(Array
				with: (FixedModelCreator creating: 1)
				with: (FixedModelCreator creating: 2))
		selectingFrom: self singleModelPicker.

	view chooseElementAt: 1.
	self assert: (creator modelIn: self) equals: 1.

	creator changeModelTo: 2 in: self.
	self assert: (creator modelIn: self) equals: 2