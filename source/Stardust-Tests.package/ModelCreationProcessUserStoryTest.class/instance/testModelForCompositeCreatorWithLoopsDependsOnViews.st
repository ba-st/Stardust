tests
testModelForCompositeCreatorWithLoopsDependsOnViews

	| discountView discountPicker someItemPriceView someItemGiftCreator anotherItemPriceView anotherItemGiftCreator totalGiftCreator totalGift supervisor |

	discountView := self singleSelectionView
		allowAnyOf: self selectableDiscounts;
		chooseElementAt: 2;
		yourself.
	discountPicker := SingleModelPicker
		named: 'selection'
		obtainingSelectionFrom: discountView.

	someItemPriceView := self textInputView.
	someItemPriceView changeContentsTo: '1100'.

	someItemGiftCreator := self
		productCreatorBetween: discountPicker
		and: someItemPriceView.

	anotherItemPriceView := self textInputView.
	anotherItemPriceView changeContentsTo: '700'.

	anotherItemGiftCreator := self
		productCreatorBetween: discountPicker
		and: anotherItemPriceView.

	totalGiftCreator := self
		sumCreatorBetween: someItemGiftCreator
		and: anotherItemGiftCreator.

	supervisor := ModelCreationSupervisor supervising: totalGiftCreator.
	totalGift := supervisor model.

	self assert: totalGift equals: 270

	"	self
		assert: totalGift leftOperand leftOperand == totalGift rightOperand leftOperand"