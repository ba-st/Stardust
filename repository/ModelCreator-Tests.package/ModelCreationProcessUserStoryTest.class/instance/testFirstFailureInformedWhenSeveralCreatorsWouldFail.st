tests
testFirstFailureInformedWhenSeveralCreatorsWouldFail

	| inputView numberCodec firstDiscountView firstDiscountPicker secondDiscountView secondDiscountPicker discountArrayCreator productCreator supervisor codec |

	inputView := TextInputViewExample new.
	numberCodec := TextCodec workingWith: (ContainerController named: 'text' controlling: inputView) parsingWith: ScaledDecimalParser new formattingWith: NullFormatter new.
	firstDiscountView := SingleSelectionViewExample new.
	firstDiscountPicker := SingleModelPicker named: 'selection' obtainingSelectionFrom: firstDiscountView.
	secondDiscountView := SingleSelectionViewExample new.
	secondDiscountPicker := SingleModelPicker named: 'selection' obtainingSelectionFrom: secondDiscountView.
	discountArrayCreator := ModelCollector named: 'collection' containing: (Array with: firstDiscountPicker with: secondDiscountPicker).
	productCreator := (GenericModelCreatorBuilder named: 'product' building: Array accessedUsing: #(first allButFirst)) with: numberCodec withAll: discountArrayCreator.
	supervisor := ModelCreationSupervisor supervising: productCreator showingErrorsAccordingTo: SupervisorStrategy displayingSingleError.
	firstDiscountView allowAnyOf: self selectableDiscounts.
	secondDiscountView allowAnyOf: self selectableDiscounts.
	inputView changeContentsTo: 'ABC'.
	self should: [ supervisor model ] raise: ModelCreationFailed withDescription: 'A valid element must be selected'