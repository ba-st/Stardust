tests
testInstanceCreationFailsWhenModelCanNotBeObtained

	| discountView discountPicker costCreator supervisor |

	discountView := SingleSelectionViewExample new.
	discountPicker := SingleModelPicker2 named: 'selection' obtainingSelectionFrom: discountView.
	costCreator := PluggableModelCreatorAdapter adapting: discountPicker with: [ :discount | 1100 * (Percentage oneHundred - discount) ].
	supervisor := ModelCreationSupervisor supervising: costCreator.
	discountView allowAnyOf: self selectableDiscounts.
	self should: [ supervisor model ] raise: ModelCreationFailed