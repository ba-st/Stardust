tests
testModelForCreatorDependsOnView

	| discountView discountPicker costCreator supervisor |

	discountView := self singleSelectionView
		allowAnyOf: self selectableDiscounts;
		chooseElementAt: 2;
		yourself.

	discountPicker := SingleModelPicker
		named: 'selection'
		obtainingSelectionFrom: discountView.

	costCreator := PluggableModelCreatorAdapter
		adapting: discountPicker
		with: [ :discount | 1100 * (Percentage oneHundred - discount) ].

	supervisor := ModelCreationSupervisor supervising: costCreator.

	self assert: supervisor model equals: 935