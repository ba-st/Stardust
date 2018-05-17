tests
testModelForCompositeCreatorDependsOnViews

	| discountView discountPicker priceToDiscountView giftCreator costCreator supervisor |

	discountView := SingleSelectionViewExample new.
	discountPicker := SingleModelPicker named: 'selection' obtainingSelectionFrom: discountView.
	priceToDiscountView := TextInputViewExample new.
	giftCreator := self productCreatorBetween: discountPicker and: priceToDiscountView.
	costCreator := PluggableModelCreatorAdapter adapting: giftCreator with: [ :gift | 1100 - gift ].
	supervisor := ModelCreationSupervisor supervising: costCreator.
	discountView allowAnyOf: self selectableDiscounts.
	discountView chooseElementAt: 2.
	priceToDiscountView changeContentsTo: '900'.
	self assert: supervisor model equals: 965