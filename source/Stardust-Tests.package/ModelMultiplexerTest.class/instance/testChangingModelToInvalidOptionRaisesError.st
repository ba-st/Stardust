tests
testChangingModelToInvalidOptionRaisesError

	| creator |

	creator := ModelMultiplexer
		multiplexing:
			(Array
				with: (FixedModelCreator creating: 1)
				with: (FixedModelCreator creating: 2))
		selectingFrom: self singleModelPicker.
	view chooseElementAt: 1.

	self assert: (creator modelIn: self) equals: 1.
	self
		should: [ creator changeModelTo: 3 in: self ]
		raise: Error
		withDescription: 'More than one vaid model was found'.
	self assert: (creator modelIn: self) equals: 1