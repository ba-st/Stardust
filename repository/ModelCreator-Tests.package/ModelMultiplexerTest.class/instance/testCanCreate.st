tests
testCanCreate

	| creator |

	creator := ModelMultiplexer
		multiplexing: (Array with: (FixedModelCreator creating: 1) with: (FixedModelCreator creating: 2))
		selectingFrom: self singleModelPicker.

	self
		assert: (creator canCreate: 1);
		assert: (creator canCreate: 2);
		deny: (creator canCreate: 3)