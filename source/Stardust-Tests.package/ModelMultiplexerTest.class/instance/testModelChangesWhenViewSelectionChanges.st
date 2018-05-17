tests
testModelChangesWhenViewSelectionChanges

	| creator |

	creator := ModelMultiplexer
		multiplexing:
			(Array
				with: (FixedModelCreator creating: 150)
				with: (FixedModelCreator creating: 232))
		selectingFrom: self singleModelPicker.

	view chooseElementAt: 1.
	self assert: (creator modelIn: self) equals: 150.

	view chooseElementAt: 2.
	self assert: (creator modelIn: self) equals: 232