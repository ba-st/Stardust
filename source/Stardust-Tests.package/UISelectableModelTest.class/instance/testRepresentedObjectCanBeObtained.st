tests
testRepresentedObjectCanBeObtained

	| item |

	item := UISelectableModel representing: self with: 'El Test'.
	self
		assert: item representedObject equals: self;
		assert: item description equals: 'El Test'