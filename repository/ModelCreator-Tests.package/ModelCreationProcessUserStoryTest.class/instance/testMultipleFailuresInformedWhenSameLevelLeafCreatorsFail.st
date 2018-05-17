tests
testMultipleFailuresInformedWhenSameLevelLeafCreatorsFail

	| firstDiscountView firstDiscountPicker secondDiscountView secondDiscountPicker productCreator
	  supervisor |

	firstDiscountView := SingleSelectionViewExample new.
	firstDiscountPicker :=
		SingleModelPicker named: 'first discount' obtainingSelectionFrom: firstDiscountView.
	secondDiscountView := SingleSelectionViewExample new.
	secondDiscountPicker :=
		SingleModelPicker named: 'second discount' obtainingSelectionFrom: secondDiscountView.
	productCreator :=
		(GenericModelCreatorBuilder
			named: 'product'
			building: MCPProduct
			accessedUsing: #(leftOperand rightOperand))
				of: firstDiscountPicker
				and: secondDiscountPicker.
	supervisor :=
		ModelCreationSupervisor
			supervising: productCreator
			showingErrorsAccordingTo: SupervisorStrategy displayingMultipleErrors.
	firstDiscountView allowAnyOf: self selectableDiscounts.
	secondDiscountView allowAnyOf: self selectableDiscounts.
	self
		should: [supervisor model]
		raise: ModelCreationFailed
		withDescription: (
			self format: (
				SortedCollection
					with: #'first discount: Se debe seleccionar un elemento v·lido'
					with: #'second discount: Se debe seleccionar un elemento v·lido'))