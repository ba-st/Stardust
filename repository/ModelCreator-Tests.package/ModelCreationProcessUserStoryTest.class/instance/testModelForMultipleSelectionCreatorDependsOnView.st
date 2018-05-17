tests
testModelForMultipleSelectionCreatorDependsOnView

	| discountsView discountsPicker costsCreator supervisor |

	discountsView := MultipleSelectionViewExample new.
	discountsPicker := MultipleModelPicker named: 'selection' obtainingSelectionFrom: discountsView.
	costsCreator := PluggableModelCreatorAdapter
		adapting: discountsPicker
		with: [ :discounts | discounts collect: [ :discount | 1100 * (Percentage oneHundred - discount) ] ].
	supervisor := ModelCreationSupervisor supervising: costsCreator.
	discountsView allowAnyOf: self selectableDiscounts.
	discountsView chooseElementsAtAll: #(1 3).
	self assert: supervisor model equals: #(990 880)