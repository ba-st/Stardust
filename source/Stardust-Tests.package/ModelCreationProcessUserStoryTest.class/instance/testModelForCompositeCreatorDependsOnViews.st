tests
testModelForCompositeCreatorDependsOnViews

	| discountView discountPicker priceToDiscountView giftCreator costCreator supervisor |

	discountView := SingleSelectionViewExample new.
	discountView allowAnyOf: self selectableDiscounts.
	discountPicker := SingleModelPicker
		named: 'selection'
		obtainingSelectionFrom: discountView.

	priceToDiscountView := self textInputView.
	giftCreator := self
		productCreatorBetween: discountPicker
		and: priceToDiscountView.

	costCreator := PluggableModelCreatorAdapter
		adapting: giftCreator
		with: [ :gift | 1100 - gift ].

	supervisor := ModelCreationSupervisor supervising: costCreator.

	discountView chooseElementAt: 2.
	priceToDiscountView changeContentsTo: '900'.

	self assert: supervisor model equals: 965