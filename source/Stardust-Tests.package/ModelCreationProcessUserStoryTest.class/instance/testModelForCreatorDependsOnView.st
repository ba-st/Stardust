tests
testModelForCreatorDependsOnView

	| discountView discountPicker costCreator supervisor |

	discountView := SingleSelectionViewExample new.
	discountPicker := SingleModelPicker
		named: 'selection'
		obtainingSelectionFrom: discountView.
	costCreator := PluggableModelCreatorAdapter
		adapting: discountPicker
		with: [ :discount | 1100 * (Percentage oneHundred - discount) ].
	supervisor := ModelCreationSupervisor supervising: costCreator.
	discountView allowAnyOf: self selectableDiscounts.
	discountView chooseElementAt: 2.
	self assert: supervisor model equals: 935