tests
testModelObtainedThroughDifferentBranchesIsIdentical

	| discountView discountCodec discountCreator someItemPriceView someItemGiftCreator anotherItemPriceView anotherItemGiftCreator totalGiftCreator supervisor totalGift |

	discountView := TextInputViewExample new.
	discountCodec := self numberCodecFor: discountView.
	discountCreator := (GenericModelCreatorBuilder named: 'percentage' building: Percentage accessedUsing: #(number)) of: discountCodec.
	someItemPriceView := TextInputViewExample new.
	someItemGiftCreator := self productCreatorBetween: discountCreator and: someItemPriceView.
	anotherItemPriceView := TextInputViewExample new.
	anotherItemGiftCreator := self productCreatorBetween: discountCreator and: anotherItemPriceView.
	totalGiftCreator := self sumCreatorBetween: someItemGiftCreator and: anotherItemGiftCreator.
	supervisor := ModelCreationSupervisor supervising: totalGiftCreator.
	discountView changeContentsTo: '15'.
	someItemPriceView changeContentsTo: '1100'.
	anotherItemPriceView changeContentsTo: '700'.
	totalGift := supervisor model.
	self assert: totalGift equals: 270.
	self assert: totalGift leftOperand leftOperand == totalGift rightOperand leftOperand