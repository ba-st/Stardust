tests
testMultipleFailuresInformedWhenDifferentLevelLeafCreatorsFail

	| firstDiscountView firstDiscountPicker secondDiscountView secondDiscountPicker thirdDiscountView thirdDiscountPicker discountArrayCreator productCreator supervisor operandsCreator |

	firstDiscountView := self singleSelectionView
		allowAnyOf: self selectableDiscounts;
		yourself.
	firstDiscountPicker := SingleModelPicker
		named: 'first discount'
		obtainingSelectionFrom: firstDiscountView.

	secondDiscountView := self singleSelectionView
		allowAnyOf: self selectableDiscounts;
		chooseElementAt: 1;
		yourself.
	secondDiscountPicker := SingleModelPicker
		named: 'second discount'
		obtainingSelectionFrom: secondDiscountView.

	thirdDiscountView := self singleSelectionView
		allowAnyOf: self selectableDiscounts;
		yourself.
	thirdDiscountPicker := SingleModelPicker
		named: 'third discount'
		obtainingSelectionFrom: thirdDiscountView.

	discountArrayCreator := ModelCollector
		named: 'discount array'
		containing: (Array with: secondDiscountPicker with: thirdDiscountPicker).

	operandsCreator := ModelCollector
		named: 'sum-operands'
		containing:
			(Array
				with: firstDiscountPicker
				with: secondDiscountPicker
				with: thirdDiscountPicker).

	productCreator := GenericModelCreatorBuilder
		named: 'sum'
		adaptingModelOf: operandsCreator
		using: [ :operands | operands sum ].

	supervisor := ModelCreationSupervisor
		supervising: productCreator
		showingErrorsAccordingTo: SupervisorStrategy displayingMultipleErrors.

	self
		should: [ supervisor model ]
		raise: ModelCreationFailed
		withDescription:
			(self
				format:
					(SortedCollection
						with: #'first discount: Se debe seleccionar un elemento v·lido'
						with: #'third discount: Se debe seleccionar un elemento v·lido'))