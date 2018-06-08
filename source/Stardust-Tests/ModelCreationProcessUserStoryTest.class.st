"
I'm a test case covering cross funcionality
"
Class {
	#name : #ModelCreationProcessUserStoryTest,
	#superclass : #CompositeModelCreatorTest,
	#instVars : [
		'ratingPicker',
		'titleCreator',
		'authorNameCreator',
		'paperCreator'
	],
	#category : #'Stardust-Tests-ModelCreation'
}

{ #category : #private }
ModelCreationProcessUserStoryTest >> firstDiscountPicker [

	| firstDiscountPicker |

	firstDiscountPicker := self newSingleModelPickerNamed: '1st Discount'.
	firstDiscountPicker allowAnyOf: self selectableDiscounts.
	^ firstDiscountPicker
]

{ #category : #private }
ModelCreationProcessUserStoryTest >> numberCodec [

	^ TextCodec
		workingWith: (ContainerController named: 'number' controlling: self newTextField)
		decodingWith: self numberDecoding
		encodingWith: self numberEncoding
]

{ #category : #private }
ModelCreationProcessUserStoryTest >> numberCodecFor: aTextView [

	^ TextCodec workingWith: (ContainerController named: 'text' controlling: aTextView) decodingWith: self numberDecoding encodingWith: self numberEncoding
]

{ #category : #private }
ModelCreationProcessUserStoryTest >> numberDecoding [

	^ [ :string | 
	[ Number readFrom: string ]
		on: Error
		do: [ :error | DecodingFailed signal: ('<1p> is not a valid number.' expandMacrosWith: string) ] ]
]

{ #category : #private }
ModelCreationProcessUserStoryTest >> numberEncoding [

	^ [ :number | number printString ]
]

{ #category : #private }
ModelCreationProcessUserStoryTest >> pointCreatorFrom: xCoordinateCreator and: yCoordinateCreator [

	^ (GenericModelCreatorBuilder named: 'point' building: Point accessedUsing: #(x y))
		x: xCoordinateCreator
		y: yCoordinateCreator
]

{ #category : #'private - accessing' }
ModelCreationProcessUserStoryTest >> productCreatorBetween: aFirstCreator and: aSecondCreator [

	| codec operandsCreator |

	codec := self numberCodecFor: aSecondCreator.
	
	operandsCreator := ModelCollector
		named: 'product-operands'
		containing: (Array with: aFirstCreator with: codec).

	^ ModelCreatorAdapter 
		named: 'product'
		adaptingModelOf: operandsCreator
		using: [ :operands | operands first * operands last ]
]

{ #category : #private }
ModelCreationProcessUserStoryTest >> rectangleCreatorFrom: originCreator to: cornerCreator [

	^ (GenericModelCreatorBuilder
		named: 'rectangle'
		building: Rectangle
		accessedUsing: #(#origin #corner))
		origin: originCreator
		corner: cornerCreator
]

{ #category : #private }
ModelCreationProcessUserStoryTest >> secondDiscountPicker [

	^ (self newSingleModelPickerNamed: '2nd Discount')
		allowAnyOf: self selectableDiscounts;
		yourself
]

{ #category : #'private - accessing' }
ModelCreationProcessUserStoryTest >> selectableDiscounts [

	^ #(10 15 20) collect: [ :number | Percentage of: number ]
]

{ #category : #running }
ModelCreationProcessUserStoryTest >> setUp [

	super setUp.
	ratingPicker := self newSingleModelPickerNamed: 'Rating'.
	ratingPicker allowAnyOf: #(1 2 3 4 5).

	titleCreator := self newContainerControllerNamed: 'Title'.

	authorNameCreator := TextCodec
		workingWith: (self newContainerControllerNamed: 'Author Name')
		decodingWith: [ :string | 
			string isEmpty
				ifTrue: [ InstanceCreationFailed signal: 'The author name cannot be empty' ]
				ifFalse: [ string ] ]
		encodingWith: [ :string | string ].

	paperCreator := (GenericModelCreatorBuilder named: 'Paper' building: StardustPaper accessedUsing: #(title authorName rating))
		titled: titleCreator
		authoredBy: authorNameCreator
		rated: ratingPicker
]

{ #category : #'private - accessing' }
ModelCreationProcessUserStoryTest >> sumCreatorBetween: aFirstCreator and: aSecondCreator [

	| operandsCreator |

	operandsCreator := ModelCollector
		named: 'sum-operands'
		containing: (Array with: aFirstCreator with: aSecondCreator).

	^ ModelCreatorAdapter
		named: 'sum'
		adaptingModelOf: operandsCreator
		using: [ :operands | operands sum ]
]

{ #category : #tests }
ModelCreationProcessUserStoryTest >> testChangingModelThroughCreatorChangesViewContents [

	| xField yField pointCreator |

	xField := self newTextField.
	yField := self newTextField.
	pointCreator := self pointCreatorFrom: (self numberCodecFor: xField) and: (self numberCodecFor: yField).

	self assertModelCreationFailedFor: pointCreator.

	pointCreator updateModelInViewsConsidering: 2 @ 3.

	self
		assertModelAssembledBy: pointCreator equals: 2 @ 3;
		assert: xField contents equals: '2';
		assert: yField contents equals: '3'
]

{ #category : #tests }
ModelCreationProcessUserStoryTest >> testChangingModelThroughCreatorWithLoopsChangesViewContents [

	| originCreator xCoordinateField originYCoordinateField cornerYCoordinateField cornerCreator xCoordinateCreator rectangleCreator |

	xCoordinateField := self newTextField.
	cornerYCoordinateField := self newTextField.
	originYCoordinateField := self newTextField.

	xCoordinateCreator := self numberCodecFor: xCoordinateField.
	originCreator := self pointCreatorFrom: xCoordinateCreator and: (self numberCodecFor: originYCoordinateField).
	cornerCreator := self pointCreatorFrom: xCoordinateCreator and: (self numberCodecFor: cornerYCoordinateField).

	rectangleCreator := self rectangleCreatorFrom: originCreator to: cornerCreator.

	rectangleCreator updateModelInViewsConsidering: (2 @ 1 corner: 2 @ 3).

	self
		assert: xCoordinateField contents equals: '2';
		assert: cornerYCoordinateField contents equals: '3';
		assert: originYCoordinateField contents equals: '1'
]

{ #category : #'tests - model creation failed' }
ModelCreationProcessUserStoryTest >> testFirstFailureInformedWhenSeveralCreatorsWouldFail [

	| textField numberCodec firstDiscountPicker discountArrayCreator productCreator supervisor |

	textField := self newTextField.
	numberCodec := self numberCodecFor: textField.
	firstDiscountPicker := self firstDiscountPicker.
	discountArrayCreator := ModelCollector named: 'collection' containing: (Array with: firstDiscountPicker with: self secondDiscountPicker).
	productCreator := (GenericModelCreatorBuilder named: 'product' building: Array accessedUsing: #(#first #allButFirst)) with: numberCodec withAll: discountArrayCreator.
	textField changeContentsTo: 'ABC'.

	supervisor := ModelCreationSupervisor supervising: productCreator showingErrorsAccordingTo: SupervisorStrategy displayingSingleError.

	self should: [ supervisor model ] raise: ModelCreationFailed withExceptionDo: [ :error | self assert: error userAwareDescriptionsByCreators size equals: 1 ]
]

{ #category : #'tests - model creation failed' }
ModelCreationProcessUserStoryTest >> testInstanceCreationFailsWhenModelCanNotBeObtained [

	| discountPicker costCreator supervisor |

	discountPicker := self newSingleModelPickerNamed: 'selection'.
	discountPicker allowAnyOf: self selectableDiscounts.
	costCreator := ModelCreatorAdapter adaptingModelOf: discountPicker using: [ :discount | 1100 * (Percentage oneHundred - discount) ].

	supervisor := ModelCreationSupervisor supervising: costCreator.

	self should: [ supervisor model ] raise: ModelCreationFailed
]

{ #category : #tests }
ModelCreationProcessUserStoryTest >> testModelForCompositeCreatorDependsOnViews [

	| discountView discountPicker priceToDiscountView giftCreator costCreator |

	discountView := DummySingleSelectionView new.
	discountPicker := SingleModelPicker named: 'selection' pickingFrom: discountView.
	discountPicker allowAnyOf: self selectableDiscounts.

	priceToDiscountView := self newTextField.
	giftCreator := self productCreatorBetween: discountPicker and: priceToDiscountView.

	costCreator := ModelCreatorAdapter adaptingModelOf: giftCreator using: [ :gift | 1100 - gift ].

	discountView chooseElementAt: 2.
	priceToDiscountView changeContentsTo: '900'.

	self assertModelAssembledBy: costCreator equals: 965
]

{ #category : #tests }
ModelCreationProcessUserStoryTest >> testModelForCompositeCreatorWithLoopsDependsOnViews [

	| discountView discountPicker someItemPriceView someItemGiftCreator anotherItemPriceView anotherItemGiftCreator totalGiftCreator |

	discountView := self newSingleSelectionView
		allowAnyOf: self selectableDiscounts;
		chooseElementAt: 2;
		yourself.
	discountPicker := SingleModelPicker named: 'selection' pickingFrom: discountView.

	someItemPriceView := self newTextField.
	someItemPriceView changeContentsTo: '1100'.

	someItemGiftCreator := self productCreatorBetween: discountPicker and: someItemPriceView.

	anotherItemPriceView := self newTextField.
	anotherItemPriceView changeContentsTo: '700'.

	anotherItemGiftCreator := self productCreatorBetween: discountPicker and: anotherItemPriceView.

	totalGiftCreator := self sumCreatorBetween: someItemGiftCreator and: anotherItemGiftCreator.

	self assertModelAssembledBy: totalGiftCreator equals: 270
]

{ #category : #tests }
ModelCreationProcessUserStoryTest >> testModelForCreatorDependsOnView [

	| discountView discountPicker costCreator |

	discountView := self newSingleSelectionView
		allowAnyOf: self selectableDiscounts;
		chooseElementAt: 2;
		yourself.

	discountPicker := SingleModelPicker named: 'selection' pickingFrom: discountView.

	costCreator := ModelCreatorAdapter adaptingModelOf: discountPicker using: [ :discount | 1100 * (Percentage oneHundred - discount) ].

	self assertModelAssembledBy: costCreator equals: 935
]

{ #category : #tests }
ModelCreationProcessUserStoryTest >> testModelForMultipleSelectionCreatorDependsOnView [

	| discountsView discountsPicker costsCreator |

	discountsView := self newMultipleSelectionView.
	discountsView allowAnyOf: self selectableDiscounts.
	discountsView chooseElementsAtAll: #(1 3).

	discountsPicker := MultipleModelPicker named: 'selection' pickingFrom: discountsView.

	costsCreator := ModelCreatorAdapter adaptingModelOf: discountsPicker using: [ :discounts | discounts collect: [ :discount | 1100 * (Percentage oneHundred - discount) ] ].

	self assertModelAssembledBy: costsCreator equals: #(990 880)
]

{ #category : #tests }
ModelCreationProcessUserStoryTest >> testModelObtainedChangesAfterUserInteraction [

	|  discountView discountCodec discountCreator |

	discountView := self newTextField.
	discountCodec := self numberCodecFor: discountView.
	discountCreator := (GenericModelCreatorBuilder named: 'percentage' building: Percentage accessedUsing: #(number)) of: discountCodec.

	discountView changeContentsTo: '15'.
	self assertModelAssembledBy: discountCreator equals: (Percentage of: 15).
	discountView changeContentsTo: '25'.
	self assertModelAssembledBy: discountCreator equals: (Percentage of: 25)
]

{ #category : #tests }
ModelCreationProcessUserStoryTest >> testModelObtainedThroughDifferentBranchesIsIdentical [

	| discountView discountCodec discountCreator someItemPriceView someItemGiftCreator anotherItemPriceView anotherItemGiftCreator totalGiftCreator |

	discountView := self newTextField.
	discountCodec := self numberCodecFor: discountView.
	discountCreator := (GenericModelCreatorBuilder named: 'percentage' building: Percentage accessedUsing: #(number)) of: discountCodec.
	someItemPriceView := self newTextField.
	someItemGiftCreator := self productCreatorBetween: discountCreator and: someItemPriceView.
	anotherItemPriceView := self newTextField.
	anotherItemGiftCreator := self productCreatorBetween: discountCreator and: anotherItemPriceView.
	totalGiftCreator := self sumCreatorBetween: someItemGiftCreator and: anotherItemGiftCreator.
	discountView changeContentsTo: '15'.
	someItemPriceView changeContentsTo: '1100'.
	anotherItemPriceView changeContentsTo: '700'.

	self assertModelAssembledBy: totalGiftCreator equals: 270
]

{ #category : #tests }
ModelCreationProcessUserStoryTest >> testModelUnnafectedByUserInteractionDoesNotChange [

	| discountField discountCreator firstItemPriceField firstItemGiftCreator secondItemPriceCreator secondItemGiftCreator totalGiftCreator |

	discountField := self newTextField.
	discountField changeContentsTo: '15'.
	discountCreator := (GenericModelCreatorBuilder named: 'percentage' building: Percentage accessedUsing: #(number)) of: (self numberCodecFor: discountField).

	firstItemPriceField := self newTextField.
	firstItemPriceField changeContentsTo: '1100'.
	firstItemGiftCreator := self productCreatorBetween: discountCreator and: firstItemPriceField.

	secondItemPriceCreator := self newTextField.
	secondItemPriceCreator changeContentsTo: '700'.
	secondItemGiftCreator := self productCreatorBetween: discountCreator and: secondItemPriceCreator.

	totalGiftCreator := self sumCreatorBetween: firstItemGiftCreator and: secondItemGiftCreator.

	self assertModelAssembledBy: totalGiftCreator equals: 270.

	firstItemPriceField changeContentsTo: '850'.
	self assertModelAssembledBy: totalGiftCreator equals: 232.5
]

{ #category : #'tests - model creation failed' }
ModelCreationProcessUserStoryTest >> testMultipleFailuresInformedWhenDifferentLevelLeafCreatorsFail [

	| firstDiscountPicker secondDiscountPicker thirdDiscountPicker supervisor operandsCreator |

	firstDiscountPicker := self newSingleModelPickerNamed: '1st discount'.
	firstDiscountPicker allowAnyOf: self selectableDiscounts.

	secondDiscountPicker := self newSingleModelPickerNamed: '2nd discount'.
	secondDiscountPicker
		allowAnyOf: self selectableDiscounts;
		updateModelInViewsConsidering: self selectableDiscounts first.

	thirdDiscountPicker := self newSingleModelPickerNamed: '3rd discount'.
	thirdDiscountPicker allowAnyOf: self selectableDiscounts.

	operandsCreator := ModelCollector named: 'operands' containing: (Array with: firstDiscountPicker with: secondDiscountPicker with: thirdDiscountPicker).

	supervisor := ModelCreationSupervisor supervising: operandsCreator showingErrorsAccordingTo: SupervisorStrategy displayingMultipleErrors.

	self
		should: [ supervisor model ]
		raise: ModelCreationFailed
		withExceptionDo: [ :error | 
			self
				assert: (error userAwareDescriptionsByCreators at: firstDiscountPicker) equals: '1st discount: A valid element must be selected';
				assert: (error userAwareDescriptionsByCreators at: thirdDiscountPicker) equals: '3rd discount: A valid element must be selected' ]
]

{ #category : #'tests - model creation failed' }
ModelCreationProcessUserStoryTest >> testMultipleFailuresInformedWhenLeafCreatorAndCompositeCreatorOnDifferentLevelsFail [

	| numberCodec firstDiscountPicker secondDiscountPicker discountArrayCreator productCreator supervisor |

	numberCodec := self numberCodec.
	firstDiscountPicker := self newSingleModelPickerNamed: 'first discount'.
	secondDiscountPicker := self newSingleModelPickerNamed: 'second discount'.
	discountArrayCreator := ModelCollector named: 'discount array' containing: (Array with: firstDiscountPicker with: secondDiscountPicker).
	productCreator := (GenericModelCreatorBuilder named: 'product' building: Array accessedUsing: #(first last)) with: numberCodec with: discountArrayCreator.

	supervisor := ModelCreationSupervisor supervising: productCreator showingErrorsAccordingTo: SupervisorStrategy displayingMultipleErrors.
	secondDiscountPicker
		allowAnyOf: self selectableDiscounts;
		updateModelInViewsConsidering: 10 percent.
	self
		should: [ supervisor model ]
		raise: ModelCreationFailed
		withExceptionDo: [ :error | 
			self
				assert: (error userAwareDescriptionsByCreators at: firstDiscountPicker) equals: 'first discount: A valid element must be selected';
				assert: (error userAwareDescriptionsByCreators at: numberCodec) equals: 'number: '''' is not a valid number.' ]
]

{ #category : #'tests - model creation failed' }
ModelCreationProcessUserStoryTest >> testMultipleFailuresInformedWhenLeafCreatorAndCompositeCreatorOnSameLevelFail [

	| numberCodec discountPicker productCreator supervisor |

	numberCodec := self numberCodec.
	discountPicker := SingleModelPicker named: 'selection' pickingFrom: self newSingleSelectionView.
	productCreator := (GenericModelCreatorBuilder named: 'product' building: Array accessedUsing: #(first last)) with: numberCodec with: discountPicker.
	supervisor := ModelCreationSupervisor supervising: productCreator showingErrorsAccordingTo: SupervisorStrategy displayingMultipleErrors.

	self
		should: [ supervisor model ]
		raise: ModelCreationFailed
		withExceptionDo: [ :error | 
			self
				assert: (error userAwareDescriptionsByCreators at: discountPicker) equals: 'selection: A valid element must be selected';
				assert: (error userAwareDescriptionsByCreators at: numberCodec) equals: 'number: '''' is not a valid number.' ]
]

{ #category : #'tests - model creation failed' }
ModelCreationProcessUserStoryTest >> testMultipleFailuresInformedWhenSameLevelLeafCreatorsFail [

	| supervisor |

	supervisor := ModelCreationSupervisor supervising: paperCreator showingErrorsAccordingTo: SupervisorStrategy displayingMultipleErrors.
	self
		should: [ supervisor model ]
		raise: ModelCreationFailed
		withExceptionDo: [ :error | 
			self
				assert: (error userAwareDescriptionsByCreators at: ratingPicker) equals: 'Rating: A valid element must be selected';
				assert: (error userAwareDescriptionsByCreators at: authorNameCreator) equals: 'Author Name: The author name cannot be empty' ]
]

{ #category : #'test - accessing' }
ModelCreationProcessUserStoryTest >> testSupervisorModelIfUnable [

	| discountView discountPicker costCreator supervisor model |

	discountView := self newSingleSelectionView.
	discountPicker := SingleModelPicker named: 'selection' pickingFrom: discountView.
	costCreator := ModelCreatorAdapter adaptingModelOf: discountPicker using: [ :discount | 1100 * (Percentage oneHundred - discount) ].
	supervisor := ModelCreationSupervisor supervising: costCreator.
	discountView allowAnyOf: self selectableDiscounts.
	self shouldnt: [ model := supervisor modelIfUnable: [ 7777 ] ] raise: ModelCreationFailed.
	self assert: model equals: 7777.
	discountView chooseElementAt: 1.
	model := supervisor modelIfUnable: [ self fail ].
	self assert: model equals: 990
]

{ #category : #'test - accessing' }
ModelCreationProcessUserStoryTest >> testSupervisorWithModelDoIfUnable [

	| supervisor model |

	supervisor := ModelCreationSupervisor supervising: paperCreator.

	model := nil.
	supervisor withModelDo: [ :theModel | self fail ] ifUnable: [ model := 32 ].
	self assert: model equals: 32.

	ratingPicker updateModelInViewsConsidering: 3.
	titleCreator updateModelInViewsConsidering: 'The greatest paper'.
	authorNameCreator updateModelInViewsConsidering: 'Juan'.

	supervisor withModelDo: [ :theModel | model := theModel ] ifUnable: [ self fail ].
	self
		assert: (model isA: StardustPaper);
		assert: model rating equals: 3;
		assert: model title equals: 'The greatest paper';
		assert: model authorName equals: 'Juan'
]
