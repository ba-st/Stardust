tests
testFirstFailureInformedWhenSeveralCreatorsWouldFail

	| inputView numberCodec firstDiscountView firstDiscountPicker secondDiscountView secondDiscountPicker discountArrayCreator productCreator supervisor |

	inputView := self textInputView.
	numberCodec := TextCodec
		workingWith: (ContainerController named: 'text' controlling: inputView)
		parsingWith: ScaledDecimalParser new
		formattingWith: NullFormatter new.

	firstDiscountView := self singleSelectionView.
	firstDiscountView allowAnyOf: self selectableDiscounts.
	firstDiscountPicker := SingleModelPicker
		named: 'selection'
		obtainingSelectionFrom: firstDiscountView.

	secondDiscountView := SingleSelectionViewExample new.
	secondDiscountView allowAnyOf: self selectableDiscounts.
	secondDiscountPicker := SingleModelPicker
		named: 'selection'
		obtainingSelectionFrom: secondDiscountView.

	discountArrayCreator := ModelCollector
		named: 'collection'
		containing: (Array with: firstDiscountPicker with: secondDiscountPicker).

	productCreator := (GenericModelCreatorBuilder
		named: 'product'
		building: Array
		accessedUsing: #(first allButFirst))
		with: numberCodec
		withAll: discountArrayCreator.

	supervisor := ModelCreationSupervisor
		supervising: productCreator
		showingErrorsAccordingTo: SupervisorStrategy displayingSingleError.

	inputView changeContentsTo: 'ABC'.

	self
		should: [ supervisor model ]
		raise: ModelCreationFailed
		withDescription: 'A valid element must be selected'