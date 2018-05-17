tests
testSupervisorModelIfUnable

	| discountView discountPicker costCreator supervisor model |

	discountView := SingleSelectionViewExample new.
	discountPicker := SingleModelPicker named: 'selection' obtainingSelectionFrom: discountView.
	costCreator := PluggableModelCreatorAdapter adapting: discountPicker with: [ :discount | 1100 * (Percentage oneHundred - discount) ].
	supervisor := ModelCreationSupervisor supervising: costCreator.
	discountView allowAnyOf: self selectableDiscounts.
	self shouldnt: [ model := supervisor modelIfUnable: [ 7777 ] ] raise: ModelCreationFailed.
	self assert: model equals: 7777.
	discountView chooseElementAt: 1.
	model := supervisor modelIfUnable: [ self fail ].
	self assert: model equals: 990