instance creation
named: aName creatingInstancesOf: modelClass sending: aSelector with: aModelCreatorCollection accessingModelWith: aSelectorCollection

	self assertSizeOf: aModelCreatorCollection equalsSizeOf: aSelectorCollection.

	^ self
		named: aName
		creatingInstancesOf: modelClass
		sending: aSelector
		with: aModelCreatorCollection
		accessingModelOnlyWith: aSelectorCollection