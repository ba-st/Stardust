instance creation
named: aName obtainingSelectionFrom: aView

	self assertNotEmpty: aName.
	^ self new initializeNamed: aName obtainingSelectionFrom: aView