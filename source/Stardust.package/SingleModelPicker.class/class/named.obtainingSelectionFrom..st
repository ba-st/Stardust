instance creation
named: aName obtainingSelectionFrom: aSingleSelectionView

	self
		deprecated:
			'We should stop using UIRepresentation since every selection view provides a way of configuring
			 the representation of its items. Commonly using ListLabelingCommand.
		Once deleted all references we must delete the ModelPickingPolicy hierarchy'.
		
	^ self named: aName obtainingSelectionFrom: aSingleSelectionView accordingTo: PickUIRepresentationPolicy new