private-instance creation
named: aName building: aModelClass accessedUsing: aCollectionOfSelectors creatingInstanceOfCreatorWith: anInstanceCreationSelector

	^ self new
		initializeNamed: aName
		building: aModelClass
		accessedUsing: aCollectionOfSelectors
		creatingInstanceOfCreatorWith: anInstanceCreationSelector