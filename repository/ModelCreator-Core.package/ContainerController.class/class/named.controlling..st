instance creation
named: aName controlling: aView

	self assertNotEmpty: aName.
	^ self new initializeNamed: aName controlling: aView