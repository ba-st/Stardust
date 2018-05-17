tests
testInstanceCreationFailsWhenModelCanNotBeObtained

	| discountView discountPicker costCreator supervisor |

	discountView := self singleSelectionView.
	discountView allowAnyOf: self selectableDiscounts.
	discountPicker := SingleModelPicker
		named: 'selection'
		obtainingSelectionFrom: discountView.

	costCreator := PluggableModelCreatorAdapter
		adapting: discountPicker
		with: [ :discount | 1100 * (Percentage oneHundred - discount) ].

	supervisor := ModelCreationSupervisor supervising: costCreator.

	self should: [ supervisor model ] raise: ModelCreationFailed