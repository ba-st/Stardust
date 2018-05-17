tests
testModelUnnafectedByUserInteractionDoesNotChange

	| discountView discountCodec discountCreator someItemPriceView someItemGiftCreator anotherItemPriceView anotherItemGiftCreator totalGiftCreator supervisor modelBeforeChange modelAfterChange |

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
	modelBeforeChange := supervisor model.
	self assert: modelBeforeChange equals: 270.
	someItemPriceView changeContentsTo: '850'.
	modelAfterChange := supervisor model.
	self assert: modelAfterChange equals: 232.5.
	self deny: modelBeforeChange leftOperand == modelAfterChange leftOperand.
	self assert: modelBeforeChange rightOperand == modelAfterChange rightOperand