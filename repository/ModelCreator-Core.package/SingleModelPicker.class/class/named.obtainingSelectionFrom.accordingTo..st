private-instance creation
named: aName obtainingSelectionFrom: aSingleSelectionView accordingTo: aModelPickingPolicy

	self assertNotEmpty: aName.
	^ self new initializeNamed: aName obtainingSelectionFrom: aSingleSelectionView accordingTo: aModelPickingPolicy