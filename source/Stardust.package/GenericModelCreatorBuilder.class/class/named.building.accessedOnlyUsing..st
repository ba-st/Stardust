instance creation
named: aName building: aModelClass accessedOnlyUsing: aCollectionOfSelectors

	^ self
		named: aName
		building: aModelClass
		accessedUsing: aCollectionOfSelectors
		creatingInstanceOfCreatorWith: #named:creatingInstancesOf:sending:with:accessingModelOnlyWith: