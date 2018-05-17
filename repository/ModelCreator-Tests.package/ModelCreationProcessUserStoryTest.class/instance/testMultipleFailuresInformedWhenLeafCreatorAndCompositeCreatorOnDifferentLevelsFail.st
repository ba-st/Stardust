tests
testMultipleFailuresInformedWhenLeafCreatorAndCompositeCreatorOnDifferentLevelsFail

	| inputView numberCodec firstDiscountView firstDiscountPicker secondDiscountView
	  secondDiscountPicker discountArrayCreator productCreator supervisor |

	inputView := TextInputViewExample new.
	numberCodec :=
		TextCodec
			workingWith: (ContainerController named: 'number' controlling: inputView)
			parsingWith: MCPNumberParser new
			formattingWith: MCPNullFormatter new.
	firstDiscountView := SingleSelectionViewExample new.
	firstDiscountPicker :=
		SingleModelPicker named: 'first discount' obtainingSelectionFrom: firstDiscountView.
	secondDiscountView := SingleSelectionViewExample new.
	secondDiscountPicker :=
		SingleModelPicker named: 'second discount' obtainingSelectionFrom: secondDiscountView.
	discountArrayCreator :=
		ModelCollector
			named: 'discount array'
			containing: (Array with: firstDiscountPicker with: secondDiscountPicker).
	productCreator :=
		(GenericModelCreatorBuilder
			named: 'product'
			building: MCPProduct
			accessedUsing: #(leftOperand rightOperand))
				of: numberCodec
				andAll: discountArrayCreator.
	supervisor :=
		ModelCreationSupervisor
			supervising: productCreator
			showingErrorsAccordingTo: SupervisorStrategy displayingMultipleErrors.
	firstDiscountView allowAnyOf: self selectableDiscounts.
	secondDiscountView allowAnyOf: self selectableDiscounts.
	inputView changeContentsTo: 'ABC'.
	secondDiscountView chooseElementAt: 1.
	self
		should: [supervisor model]
		raise: ModelCreationFailed
		withDescription: (
			self format: (
				SortedCollection
					with: #'number: ABC no representa un n˙mero'
					with: #'first discount: Se debe seleccionar un elemento v·lido'))