instance creation
named: aName containing: anCollectionOfModelCreators

	self assertNotEmpty: aName.
	^ self new initializeNamed: aName containing: anCollectionOfModelCreators