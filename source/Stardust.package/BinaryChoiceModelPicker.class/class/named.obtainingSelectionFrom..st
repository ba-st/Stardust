instance creation
named: aName obtainingSelectionFrom: aBinaryChoiceView

	self assertNotEmpty: aName.
	^ self new initializeNamed: aName obtainingSelectionFrom: aBinaryChoiceView