"
I'm a test case covering cross funcionality
"
Class {
	#name : #ModelCreationProcessUserStoryTest,
	#superclass : #TestCase,
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
ModelCreationProcessUserStoryTest >> newSingleModelPickerNamed: aName [

	^ SingleModelPicker named: aName pickingFrom: self newSingleSelectionView
]

{ #category : #'widget - support' }
ModelCreationProcessUserStoryTest >> newSingleSelectionView [

	^ DummySingleSelectionView new
]

{ #category : #private }
ModelCreationProcessUserStoryTest >> numberCodec [

	^ TextCodec
		workingWith: (ContainerController named: 'number' controlling: self textField)
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

{ #category : #private }
ModelCreationProcessUserStoryTest >> rectangleCreatorFrom: originPicker to: cornerCreator [

	^ (GenericModelCreatorBuilder
		named: 'rectangle'
		building: Rectangle
		accessedUsing: #(#origin #corner))
		origin: originPicker
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

{ #category : #'private - accessing' }
ModelCreationProcessUserStoryTest >> selectablePoints [

	^ #(1 2 3) collect: [ :number | number @ number ]
]

{ #category : #running }
ModelCreationProcessUserStoryTest >> setUp [

	super setUp.
	ratingPicker := SingleModelPicker named: 'Rating' pickingFrom: self newSingleSelectionView.
	titleCreator := ContainerController named: 'Title' controlling: self textField.
	authorNameCreator := TextCodec
		workingWith: (ContainerController named: 'Author Name' controlling: self textField)
		decodingWith: [ :string | 
			string isEmpty
				ifTrue: [ InstanceCreationFailed signal: 'The author name cannot be empty' ]
				ifFalse: [ string ] ]
		encodingWith: [ :string | string ].
	paperCreator := (GenericModelCreatorBuilder named: 'Paper' building: StardustPaper accessedUsing: #(title authorName rating)) titled: titleCreator authoredBy: authorNameCreator rated: ratingPicker
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

	originView := self newSingleSelectionView
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

	| textField numberCodec firstDiscountPicker discountArrayCreator productCreator supervisor |

	textField := self textField.
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

	discountView := self newSingleSelectionView
		allowAnyOf: self selectableDiscounts;
		chooseElementAt: 2;
		yourself.
	discountPicker := SingleModelPicker named: 'selection' pickingFrom: discountView.

	someItemPriceView := self textField.
	someItemPriceView changeContentsTo: '1100'.

	someItemGiftCreator := self productCreatorBetween: discountPicker and: someItemPriceView.

	anotherItemPriceView := self textField.
	anotherItemPriceView changeContentsTo: '700'.

	anotherItemGiftCreator := self
		productCreatorBetween: discountPicker
		and: anotherItemPriceView.

	totalGiftCreator := self
		sumCreatorBetween: someItemGiftCreator
		and: anotherItemGiftCreator.

	supervisor := ModelCreationSupervisor supervising: totalGiftCreator.
	totalGift := supervisor model.

	self assert: totalGift equals: 270
]

{ #category : #tests }
ModelCreationProcessUserStoryTest >> testModelForCreatorDependsOnView [

	| discountView discountPicker costCreator supervisor |

	discountView := self newSingleSelectionView
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

{ #category : #'tests - model creation failed' }
ModelCreationProcessUserStoryTest >> testSupervisorModelIfUnable [

	| discountView discountPicker costCreator supervisor model |

	discountView := self newSingleSelectionView.
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

	| supervisor model |

	supervisor := ModelCreationSupervisor supervising: paperCreator.

	ratingPicker allowAnyOf: #(1 2 3 4 5).

	model := supervisor withModelDo: [ :theModel | self fail ] ifUnable: [ 7777 ].
	self assert: model equals: 7777.

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

{ #category : #'widget - support' }
ModelCreationProcessUserStoryTest >> textField [

	^ DummyTextInput new
]
