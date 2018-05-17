instance creation
named: aName creatingInstancesOf: modelClass sending: aSelector with: aModelCreatorCollection accessingModelOnlyWith: aSelectorCollection

	self assertNotEmpty: aName.
	self assertSizeOf: aModelCreatorCollection equalsArgumentCountOf: aSelector.

	^ self new
		initializeNamed: aName
		creatingInstancesOf: modelClass
		sending: aSelector
		with: aModelCreatorCollection
		accessingModelOnlyWith: aSelectorCollection