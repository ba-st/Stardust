tests
testRepresentedObjectCanBeObtained

	| item |

	item := UISelectableModel2 representing: self with: 'El Test'.
	self
		assert: item representedObject equals: self;
		assert: item description equals: 'El Test'