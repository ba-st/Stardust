tests
testMultipleFailuresInformedWhenDifferentLevelLeafCreatorsFail

	| firstDiscountView firstDiscountPicker secondDiscountView secondDiscountPicker thirdDiscountView thirdDiscountPicker discountArrayCreator productCreator supervisor |

	firstDiscountView := SingleSelectionViewExample new.
	firstDiscountPicker := SingleModelPicker
		named: 'first discount'
		obtainingSelectionFrom: firstDiscountView.
	secondDiscountView := SingleSelectionViewExample new.
	secondDiscountPicker := SingleModelPicker
		named: 'second discount'
		obtainingSelectionFrom: secondDiscountView.
	thirdDiscountView := SingleSelectionViewExample new.
	thirdDiscountPicker := SingleModelPicker
		named: 'third discount'
		obtainingSelectionFrom: thirdDiscountView.
	discountArrayCreator := ModelCollector
		named: 'discount array'
		containing: (Array with: secondDiscountPicker with: thirdDiscountPicker).
	productCreator := (GenericModelCreatorBuilder
		named: 'product'
		building: nil
		accessedUsing: #(leftOperand rightOperand))
		of: firstDiscountPicker
		andAll: discountArrayCreator.
	supervisor := ModelCreationSupervisor
		supervising: productCreator
		showingErrorsAccordingTo: SupervisorStrategy displayingMultipleErrors.
	firstDiscountView allowAnyOf: self selectableDiscounts.
	secondDiscountView allowAnyOf: self selectableDiscounts.
	thirdDiscountView allowAnyOf: self selectableDiscounts.
	secondDiscountView chooseElementAt: 1.
	self
		should: [ supervisor model ]
		raise: ModelCreationFailed
		withDescription:
			(self
				format:
					(SortedCollection
						with: #'first discount: Se debe seleccionar un elemento v·lido'
						with: #'third discount: Se debe seleccionar un elemento v·lido'))