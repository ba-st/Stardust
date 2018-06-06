"
I'm a test case covering cross funcionality
"
Class {
	#name : #ModelCreationProcessUserStoryTest,
	#superclass : #TestCase,
	#category : #'Stardust-Tests-ModelCreation'
}

{ #category : #'private - accessing' }
ModelCreationProcessUserStoryTest >> format: aCollection [

	^ (CollectionFormatter separatingWith: Character cr) format: aCollection
]

{ #category : #'private - building' }
ModelCreationProcessUserStoryTest >> numberCodecFor: aTextView [

	^ TextCodec
		workingWith: (ContainerController named: 'text' controlling: aTextView)
		decodingWith: [ :string | 
			[ Number readFrom: string ]
				on: Error
				do: [ :error | DecodingFailed signal: error messageText ] ]
		encodingWith: [ :number | number printString ]
]

{ #category : #'private - building' }
ModelCreationProcessUserStoryTest >> pointCreatorFrom: cornerXView and: cornerYView [

	^ (GenericModelCreatorBuilder
		named: 'corner'
		building: Point
		accessedUsing: #(x y))
		x: (self numberCodecFor: cornerXView)
		y: (self numberCodecFor: cornerYView)
]

{ #category : #'private - accessing' }
ModelCreationProcessUserStoryTest >> productCreatorBetween: aFirstCreator and: aSecondCreator [

	| codec operandsCreator |

	codec := self numberCodecFor: aSecondCreator.
	
	operandsCreator := ModelCollector
		named: 'product-operands'
		containing: (Array with: aFirstCreator with: codec).

	^ GenericModelCreatorBuilder
		named: 'product'
		adaptingModelOf: operandsCreator
		using: [ :operands | operands first * operands last ]
]

{ #category : #'private - building' }
ModelCreationProcessUserStoryTest >> rectangleCreatorFrom: originPicker to: cornerCreator [

	^ (GenericModelCreatorBuilder
		named: 'rectangle'
		building: Rectangle
		accessedUsing: #(#origin #corner))
		origin: originPicker
		corner: cornerCreator
]

{ #category : #'private - accessing' }
ModelCreationProcessUserStoryTest >> selectableDiscounts [

	^ #(10 15 20) collect: [ :number | Percentage of: number ]
]

{ #category : #'private - accessing' }
ModelCreationProcessUserStoryTest >> selectablePoints [

	^ #(1 2 3) collect: [ :number | number @ number ]
]

{ #category : #'widget - support' }
ModelCreationProcessUserStoryTest >> singleSelectionView [

	^ DummySingleSelectionView new
]

{ #category : #'private - accessing' }
ModelCreationProcessUserStoryTest >> sumCreatorBetween: aFirstCreator and: aSecondCreator [

	| operandsCreator |

	operandsCreator := ModelCollector
		named: 'sum-operands'
		containing: (Array with: aFirstCreator with: aSecondCreator).

	^ GenericModelCreatorBuilder
		named: 'sum'
		adaptingModelOf: operandsCreator
		using: [ :operands | operands sum ]
]

{ #category : #tests }
ModelCreationProcessUserStoryTest >> testChangingModelThroughCreatorChangesViewContents [

	| cornerXView cornerYView cornerCreator supervisor |

	cornerXView := self textField.
	cornerYView := self textField.
	cornerCreator := self pointCreatorFrom: cornerXView and: cornerYView.

	supervisor := ModelCreationSupervisor supervising: cornerCreator.

	self should: [ supervisor model ] raise: ModelCreationFailed.

	supervisor changeModelTo: 2 @ 3.

	self assert: cornerXView contents equals: '2'.
	self assert: cornerYView contents equals: '3'
]

{ #category : #tests }
ModelCreationProcessUserStoryTest >> testChangingModelThroughCreatorWithLoopsChangesViewContents [

	| originView originPicker cornerXView cornerYView cornerCreator rectangleCreator supervisor |

	originView := self singleSelectionView
		allowAnyOf: self selectablePoints;
		yourself.
	originPicker := SingleModelPicker named: 'origin' pickingFrom: originView.

	cornerXView := self textField.
	cornerYView := self textField.
	cornerCreator := self pointCreatorFrom: cornerXView and: cornerYView.

	rectangleCreator := self rectangleCreatorFrom: originPicker to: cornerCreator.

	supervisor := ModelCreationSupervisor supervising: rectangleCreator.
	supervisor changeModelTo: (1 @ 1 corner: 2 @ 3).

	self assert: originView chosenIndex equals: 1.
	self assert: cornerXView contents equals: '2'.
	self assert: cornerYView contents equals: '3'
]

{ #category : #'tests - model creation failed' }
ModelCreationProcessUserStoryTest >> testFirstFailureInformedWhenSeveralCreatorsWouldFail [

	| textField numberCodec firstDiscountView firstDiscountPicker secondDiscountView secondDiscountPicker discountArrayCreator productCreator supervisor |

	textField := self textField.
	numberCodec := self numberCodecFor: textField.

	firstDiscountView := self singleSelectionView.
	firstDiscountView allowAnyOf: self selectableDiscounts.
	firstDiscountPicker := SingleModelPicker named: 'selection' pickingFrom: firstDiscountView.

	secondDiscountView := self singleSelectionView.
	secondDiscountView allowAnyOf: self selectableDiscounts.
	secondDiscountPicker := SingleModelPicker named: 'selection' pickingFrom: secondDiscountView.

	discountArrayCreator := ModelCollector named: 'collection' containing: (Array with: firstDiscountPicker with: secondDiscountPicker).

	productCreator := (GenericModelCreatorBuilder named: 'product' building: Array accessedUsing: #(first allButFirst)) with: numberCodec withAll: discountArrayCreator.

	supervisor := ModelCreationSupervisor supervising: productCreator showingErrorsAccordingTo: SupervisorStrategy displayingSingleError.

	textField changeContentsTo: 'ABC'.

	self should: [ supervisor model ] raise: ModelCreationFailed withExceptionDo: [ :error | self assert: (error messageText endsWith: 'A valid element must be selected') ]
]

{ #category : #'tests - model creation failed' }
ModelCreationProcessUserStoryTest >> testInstanceCreationFailsWhenModelCanNotBeObtained [

	| discountView discountPicker costCreator supervisor |

	discountView := self singleSelectionView.
	discountView allowAnyOf: self selectableDiscounts.
	discountPicker := SingleModelPicker named: 'selection' pickingFrom: discountView.

	costCreator := PluggableModelCreatorAdapter adapting: discountPicker with: [ :discount | 1100 * (Percentage oneHundred - discount) ].

	supervisor := ModelCreationSupervisor supervising: costCreator.

	self should: [ supervisor model ] raise: ModelCreationFailed
]

{ #category : #tests }
ModelCreationProcessUserStoryTest >> testModelForCompositeCreatorDependsOnViews [

	| discountView discountPicker priceToDiscountView giftCreator costCreator supervisor |

	discountView := DummySingleSelectionView new.
	discountView allowAnyOf: self selectableDiscounts.
	discountPicker := SingleModelPicker named: 'selection' pickingFrom: discountView.

	priceToDiscountView := self textField.
	giftCreator := self productCreatorBetween: discountPicker and: priceToDiscountView.

	costCreator := PluggableModelCreatorAdapter adapting: giftCreator with: [ :gift | 1100 - gift ].

	supervisor := ModelCreationSupervisor supervising: costCreator.

	discountView chooseElementAt: 2.
	priceToDiscountView changeContentsTo: '900'.

	self assert: supervisor model equals: 965
]

{ #category : #tests }
ModelCreationProcessUserStoryTest >> testModelForCompositeCreatorWithLoopsDependsOnViews [

	| discountView discountPicker someItemPriceView someItemGiftCreator anotherItemPriceView anotherItemGiftCreator totalGiftCreator totalGift supervisor |

	discountView := self singleSelectionView
		allowAnyOf: self selectableDiscounts;
		chooseElementAt: 2;
		yourself.
	discountPicker := SingleModelPicker named: 'selection' pickingFrom: discountView.

	someItemPriceView := self textField.
	someItemPriceView changeContentsTo: '1100'.

	someItemGiftCreator := self productCreatorBetween: discountPicker and: someItemPriceView.

	anotherItemPriceView := self textField.
	anotherItemPriceView changeContentsTo: '700'.

	anotherItemGiftCreator := self productCreatorBetween: discountPicker and: anotherItemPriceView.

	totalGiftCreator := self sumCreatorBetween: someItemGiftCreator and: anotherItemGiftCreator.

	supervisor := ModelCreationSupervisor supervising: totalGiftCreator.
	totalGift := supervisor model.

	self assert: totalGift equals: 270

	"	self
		assert: totalGift leftOperand leftOperand == totalGift rightOperand leftOperand"
]

{ #category : #tests }
ModelCreationProcessUserStoryTest >> testModelForCreatorDependsOnView [

	| discountView discountPicker costCreator supervisor |

	discountView := self singleSelectionView
		allowAnyOf: self selectableDiscounts;
		chooseElementAt: 2;
		yourself.

	discountPicker := SingleModelPicker named: 'selection' pickingFrom: discountView.

	costCreator := PluggableModelCreatorAdapter adapting: discountPicker with: [ :discount | 1100 * (Percentage oneHundred - discount) ].

	supervisor := ModelCreationSupervisor supervising: costCreator.

	self assert: supervisor model equals: 935
]

{ #category : #tests }
ModelCreationProcessUserStoryTest >> testModelForMultipleSelectionCreatorDependsOnView [

	| discountsView discountsPicker costsCreator supervisor |

	discountsView := DummyMultipleSelectionView new.
	discountsView allowAnyOf: self selectableDiscounts.
	discountsView chooseElementsAtAll: #(1 3).

	discountsPicker := MultipleModelPicker named: 'selection' pickingFrom: discountsView.

	costsCreator := PluggableModelCreatorAdapter adapting: discountsPicker with: [ :discounts | discounts collect: [ :discount | 1100 * (Percentage oneHundred - discount) ] ].

	supervisor := ModelCreationSupervisor supervising: costsCreator.

	self assert: supervisor model equals: #(990 880)
]

{ #category : #tests }
ModelCreationProcessUserStoryTest >> testModelObtainedChangesAfterUserInteraction [

	| supervisor discountView discountCodec discountCreator |

	discountView := DummyTextInput new.
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
]

{ #category : #tests }
ModelCreationProcessUserStoryTest >> testModelObtainedThroughDifferentBranchesIsIdentical [

	| discountView discountCodec discountCreator someItemPriceView someItemGiftCreator anotherItemPriceView anotherItemGiftCreator totalGiftCreator supervisor totalGift |

	discountView := self textField.
	discountCodec := self numberCodecFor: discountView.
	discountCreator := (GenericModelCreatorBuilder named: 'percentage' building: Percentage accessedUsing: #(number)) of: discountCodec.
	someItemPriceView := self textField.
	someItemGiftCreator := self productCreatorBetween: discountCreator and: someItemPriceView.
	anotherItemPriceView := self textField.
	anotherItemGiftCreator := self productCreatorBetween: discountCreator and: anotherItemPriceView.
	totalGiftCreator := self sumCreatorBetween: someItemGiftCreator and: anotherItemGiftCreator.
	supervisor := ModelCreationSupervisor supervising: totalGiftCreator.
	discountView changeContentsTo: '15'.
	someItemPriceView changeContentsTo: '1100'.
	anotherItemPriceView changeContentsTo: '700'.
	totalGift := supervisor model.
	self assert: totalGift equals: 270
]

{ #category : #tests }
ModelCreationProcessUserStoryTest >> testModelUnnafectedByUserInteractionDoesNotChange [

	| discountView discountCreator someItemPriceView someItemGiftCreator anotherItemPriceView anotherItemGiftCreator totalGiftCreator supervisor modelBeforeChange modelAfterChange |

	discountView := self textField
		changeContentsTo: '15';
		yourself.
	discountCreator := (GenericModelCreatorBuilder named: 'percentage' building: Percentage accessedUsing: #(number)) of: (self numberCodecFor: discountView).

	someItemPriceView := self textField
		changeContentsTo: '1100';
		yourself.
	someItemGiftCreator := self productCreatorBetween: discountCreator and: someItemPriceView.

	anotherItemPriceView := self textField
		changeContentsTo: '700';
		yourself.
	anotherItemGiftCreator := self productCreatorBetween: discountCreator and: anotherItemPriceView.

	totalGiftCreator := self sumCreatorBetween: someItemGiftCreator and: anotherItemGiftCreator.
	supervisor := ModelCreationSupervisor supervising: totalGiftCreator.

	modelBeforeChange := supervisor model.
	self assert: modelBeforeChange equals: 270.

	someItemPriceView changeContentsTo: '850'.
	modelAfterChange := supervisor model.
	self assert: modelAfterChange equals: 232.5
]

{ #category : #tests }
ModelCreationProcessUserStoryTest >> testMultipleFailuresInformedWhenDifferentLevelLeafCreatorsFail [

	| firstDiscountView firstDiscountPicker secondDiscountView secondDiscountPicker thirdDiscountView thirdDiscountPicker productCreator supervisor operandsCreator |

	firstDiscountView := self singleSelectionView
		allowAnyOf: self selectableDiscounts;
		yourself.
	firstDiscountPicker := SingleModelPicker named: 'first discount' pickingFrom: firstDiscountView.

	secondDiscountView := self singleSelectionView
		allowAnyOf: self selectableDiscounts;
		chooseElementAt: 1;
		yourself.
	secondDiscountPicker := SingleModelPicker named: 'second discount' pickingFrom: secondDiscountView.

	thirdDiscountView := self singleSelectionView
		allowAnyOf: self selectableDiscounts;
		yourself.
	thirdDiscountPicker := SingleModelPicker named: 'third discount' pickingFrom: thirdDiscountView.

	operandsCreator := ModelCollector named: 'sum-operands' containing: (Array with: firstDiscountPicker with: secondDiscountPicker with: thirdDiscountPicker).

	productCreator := GenericModelCreatorBuilder named: 'sum' adaptingModelOf: operandsCreator using: [ :operands | operands sum ].

	supervisor := ModelCreationSupervisor supervising: productCreator showingErrorsAccordingTo: SupervisorStrategy displayingMultipleErrors.

	self
		should: [ supervisor model ]
		raise: ModelCreationFailed
		withExceptionDo: [ :error | self assert: error messageText equals: (self format: (SortedCollection with: 'first discount: A valid element must be selected' with: 'third discount: A valid element must be selected')) ]
]

{ #category : #tests }
ModelCreationProcessUserStoryTest >> testMultipleFailuresInformedWhenLeafCreatorAndCompositeCreatorOnDifferentLevelsFail [

	| inputView numberCodec firstDiscountView firstDiscountPicker secondDiscountView secondDiscountPicker discountArrayCreator productCreator supervisor |

	inputView := DummyTextInput new.
	numberCodec := TextCodec workingWith: (ContainerController named: 'number' controlling: inputView) parsingWith: IntegerParser new formattingWith: NullFormatter new.
	firstDiscountView := DummySingleSelectionView new.
	firstDiscountPicker := SingleModelPicker named: 'first discount' pickingFrom: firstDiscountView.
	secondDiscountView := DummySingleSelectionView new.
	secondDiscountPicker := SingleModelPicker named: 'second discount' pickingFrom: secondDiscountView.
	discountArrayCreator := ModelCollector named: 'discount array' containing: (Array with: firstDiscountPicker with: secondDiscountPicker).
	productCreator := (GenericModelCreatorBuilder named: 'product' building: Array accessedUsing: #(first last)) with: numberCodec with: discountArrayCreator.
	supervisor := ModelCreationSupervisor supervising: productCreator showingErrorsAccordingTo: SupervisorStrategy displayingMultipleErrors.
	firstDiscountView allowAnyOf: self selectableDiscounts.
	secondDiscountView allowAnyOf: self selectableDiscounts.
	inputView changeContentsTo: 'ABC'.
	secondDiscountView chooseElementAt: 1.
	self
		should: [ supervisor model ]
		raise: ModelCreationFailed
		withExceptionDo: [ :error | 
			self
				assert: error messageText
				equals:
					(self
						format:
							(SortedCollection
								with: 'number: First character of an integer is either a digit, + or -, not A. An integer only contains digits optionally prepended by + or -'
								with: 'first discount: A valid element must be selected')) ]
]

{ #category : #tests }
ModelCreationProcessUserStoryTest >> testMultipleFailuresInformedWhenLeafCreatorAndCompositeCreatorOnSameLevelFail [

	| inputView numberCodec discountView discountPicker productCreator supervisor |

	inputView := DummyTextInput new.
	numberCodec := TextCodec workingWith: (ContainerController named: 'text' controlling: inputView) parsingWith: IntegerParser new formattingWith: NullFormatter new.
	discountView := DummySingleSelectionView new.
	discountPicker := SingleModelPicker named: 'selection' obtainingSelectionFrom: discountView.
	productCreator := (GenericModelCreatorBuilder named: 'product' building: nil accessedUsing: #(leftOperand rightOperand)) of: numberCodec and: discountPicker.
	supervisor := ModelCreationSupervisor supervising: productCreator showingErrorsAccordingTo: SupervisorStrategy displayingMultipleErrors.
	discountView allowAnyOf: self selectableDiscounts.
	inputView changeContentsTo: 'ABC'.
	self
		should: [ supervisor model ]
		raise: ModelCreationFailed
		withExceptionDo: [ :error | 
			self
				assert: error messageText
				equals:
					(self
						format:
							(SortedCollection
								with: #'text: First character of an integer is either a digit, + or -, not A. An integer only contains digits optionally prepended by + or -'
								with: #'selection: A valid element must be selected')) ]
]

{ #category : #tests }
ModelCreationProcessUserStoryTest >> testMultipleFailuresInformedWhenSameLevelLeafCreatorsFail [

	| firstDiscountView firstDiscountPicker secondDiscountView secondDiscountPicker productCreator supervisor |

	firstDiscountView := self singleSelectionView.
	firstDiscountPicker := SingleModelPicker named: 'first discount' pickingFrom: firstDiscountView.
	secondDiscountView := self singleSelectionView.
	secondDiscountPicker := SingleModelPicker named: 'second discount' pickingFrom: secondDiscountView.
	productCreator := self productCreatorBetween: firstDiscountPicker and: secondDiscountPicker.
	supervisor := ModelCreationSupervisor supervising: productCreator showingErrorsAccordingTo: SupervisorStrategy displayingMultipleErrors.
	firstDiscountView allowAnyOf: self selectableDiscounts.
	secondDiscountView allowAnyOf: self selectableDiscounts.
	self
		should: [ supervisor model ]
		raise: ModelCreationFailed
		withExceptionDo: [ :error | self assert: error messageText equals: (self format: (SortedCollection with: 'first discount: A valid element must be selected' with: 'second discount: A valid element must be selected')) ]
]

{ #category : #'tests - model creation failed' }
ModelCreationProcessUserStoryTest >> testSupervisorModelIfUnable [

	| discountView discountPicker costCreator supervisor model |

	discountView := DummySingleSelectionView new.
	discountPicker := SingleModelPicker named: 'selection' pickingFrom: discountView.
	costCreator := PluggableModelCreatorAdapter adapting: discountPicker with: [ :discount | 1100 * (Percentage oneHundred - discount) ].
	supervisor := ModelCreationSupervisor supervising: costCreator.
	discountView allowAnyOf: self selectableDiscounts.
	self shouldnt: [ model := supervisor modelIfUnable: [ 7777 ] ] raise: ModelCreationFailed.
	self assert: model equals: 7777.
	discountView chooseElementAt: 1.
	model := supervisor modelIfUnable: [ self fail ].
	self assert: model equals: 990
]

{ #category : #tests }
ModelCreationProcessUserStoryTest >> testSupervisorWithModelDoIfUnable [

	| discountView discountPicker costCreator supervisor model |

	discountView := self singleSelectionView.
	discountPicker := SingleModelPicker named: 'selection' pickingFrom: discountView.
	costCreator := PluggableModelCreatorAdapter adapting: discountPicker with: [ :discount | 1100 * (Percentage oneHundred - discount) ].
	supervisor := ModelCreationSupervisor supervising: costCreator.
	discountView allowAnyOf: self selectableDiscounts.
	self shouldnt: [ model := supervisor withModelDo: [ :theModel | self fail ] ifUnable: [ 7777 ] ] raise: ModelCreationFailed.
	self assert: model equals: 7777.
	discountView chooseElementAt: 1.
	supervisor withModelDo: [ :theModel | model := theModel ] ifUnable: [ self fail ].
	self assert: model equals: 990
]

{ #category : #'widget - support' }
ModelCreationProcessUserStoryTest >> textField [

	^ DummyTextInput new
]
