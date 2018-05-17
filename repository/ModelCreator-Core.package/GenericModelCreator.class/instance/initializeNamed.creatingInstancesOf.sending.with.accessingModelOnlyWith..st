initialization
initializeNamed: aName creatingInstancesOf: aModelClassOrBlock sending: aSelector with: aModelCreatorCollection accessingModelOnlyWith: aSelectorCollection

	name := aName.
	modelClassReference := aModelClassOrBlock isClass
		ifTrue: [ aModelClassOrBlock ]
		ifFalse: [ "The block inside block is intentional. See self>>#modelIn:" [ aModelClassOrBlock ] ].

	instanceCreationSelector := aSelector.
	modelCreators := aModelCreatorCollection.
	accessors := aSelectorCollection