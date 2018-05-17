tests
testModelObtainedChangesAfterUserInteraction

	| supervisor discountView discountCodec discountCreator |

	discountView := TextInputViewExample new.
	discountCodec := self numberCodecFor: discountView.
	discountCreator := (GenericModelCreatorBuilder
		named: 'percentage'
		building: Percentage
		accessedUsing: #(number)) of: discountCodec.
	supervisor := ModelCreationSupervisor supervising: discountCreator.
	discountView changeContentsTo: '15'.
	self assert: supervisor model equals: (Percentage of: 15).
	discountView changeContentsTo: '25'.
	self assert: supervisor model equals: (Percentage of: 25)