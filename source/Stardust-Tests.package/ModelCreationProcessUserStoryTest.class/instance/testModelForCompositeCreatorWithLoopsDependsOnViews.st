tests
testModelForCompositeCreatorWithLoopsDependsOnViews

	| discountView discountPicker someItemPriceView someItemGiftCreator anotherItemPriceView anotherItemGiftCreator totalGiftCreator totalGift supervisor |

	discountView := SingleSelectionViewExample new.
	discountPicker := SingleModelPicker2 named: 'selection' obtainingSelectionFrom: discountView.
	someItemPriceView := TextInputViewExample new.
	someItemGiftCreator := self productCreatorBetween: discountPicker and: someItemPriceView.
	anotherItemPriceView := TextInputViewExample new.
	anotherItemGiftCreator := self productCreatorBetween: discountPicker and: anotherItemPriceView.
	totalGiftCreator := self sumCreatorBetween: someItemGiftCreator and: anotherItemGiftCreator.
	supervisor := ModelCreationSupervisor supervising: totalGiftCreator.
	discountView allowAnyOf: self selectableDiscounts.
	discountView chooseElementAt: 2.
	someItemPriceView changeContentsTo: '1100'.
	anotherItemPriceView changeContentsTo: '700'.
	totalGift := supervisor model.
	self assert: totalGift equals: 270.
	self assert: totalGift leftOperand leftOperand == totalGift rightOperand leftOperand