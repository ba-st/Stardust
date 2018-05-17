tests
testModelUnnafectedByUserInteractionDoesNotChange

	| discountView discountCreator someItemPriceView someItemGiftCreator anotherItemPriceView anotherItemGiftCreator totalGiftCreator supervisor modelBeforeChange modelAfterChange |

	discountView := self textInputView
		changeContentsTo: '15';
		yourself.
	discountCreator := (GenericModelCreatorBuilder
		named: 'percentage'
		building: Percentage
		accessedUsing: #(number)) of: (self numberCodecFor: discountView).

	someItemPriceView := self textInputView
		changeContentsTo: '1100';
		yourself.
	someItemGiftCreator := self
		productCreatorBetween: discountCreator
		and: someItemPriceView.

	anotherItemPriceView := self textInputView
		changeContentsTo: '700';
		yourself.
	anotherItemGiftCreator := self
		productCreatorBetween: discountCreator
		and: anotherItemPriceView.

	totalGiftCreator := self
		sumCreatorBetween: someItemGiftCreator
		and: anotherItemGiftCreator.
	supervisor := ModelCreationSupervisor supervising: totalGiftCreator.

	modelBeforeChange := supervisor model.
	self assert: modelBeforeChange equals: 270.

	someItemPriceView changeContentsTo: '850'.
	modelAfterChange := supervisor model.
	self assert: modelAfterChange equals: 232.5

	"	self deny: modelBeforeChange leftOperand == modelAfterChange leftOperand.
	self assert: modelBeforeChange rightOperand == modelAfterChange rightOperand"