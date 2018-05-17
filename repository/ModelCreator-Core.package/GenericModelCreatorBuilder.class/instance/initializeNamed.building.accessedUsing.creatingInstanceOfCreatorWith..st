private-accessing
initializeNamed: aName building: aModelClass accessedUsing: aCollectionOfSelectors creatingInstanceOfCreatorWith: anInstanceCreationSelector

	name := aName.
	modelClass := aModelClass.
	accessors := aCollectionOfSelectors.
	creatorInstantiator := anInstanceCreationSelector