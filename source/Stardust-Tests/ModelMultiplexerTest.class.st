"
I'm a test case
"
Class {
	#name : #ModelMultiplexerTest,
	#superclass : #CompositeModelCreatorTest,
	#instVars : [
		'singleSelectionView',
		'picker'
	],
	#category : #'Stardust-Tests-ModelCreation'
}

{ #category : #'private - accessing' }
ModelMultiplexerTest >> modelFor: aSingleModelPicker [

	^ singleSelectionView currentSelectionIfNone: [ self fail ]
]

{ #category : #running }
ModelMultiplexerTest >> setUp [

	super setUp.
	singleSelectionView := self newSingleSelectionView.
	picker := SingleModelPicker named: 'Test' pickingFrom: singleSelectionView
]

{ #category : #tests }
ModelMultiplexerTest >> testAccessing [

	| multiplexer |

	multiplexer := ModelMultiplexer multiplexing: (Array with: (self newSingleModelPickerNamed: 'Discount') with: (self newFixedCreatorFor: 232)) selectingFrom: picker.

	self assert: multiplexer name equals: picker name
]

{ #category : #tests }
ModelMultiplexerTest >> testCanCreate [

	| creator |

	creator := ModelMultiplexer multiplexing: (Array with: (self newFixedCreatorFor: 1) with: (self newFixedCreatorFor: $A)) selectingFrom: picker.

	self
		assert: (creator canCreate: 1);
		assert: (creator canCreate: $A);
		deny: (creator canCreate: 3);
		deny: (creator canCreate: 'ZZ')
]

{ #category : #tests }
ModelMultiplexerTest >> testChangingModelToInvalidOptionRaisesError [

	| creator |

	creator := ModelMultiplexer multiplexing: (Array with: (self newFixedCreatorFor: 99) with: (self newFixedCreatorFor: $A)) selectingFrom: picker.
	
	picker updateModelInViewsConsidering: '99'.

	self assertModelAssembledBy: creator equals: 99.

	self should: [ creator updateModelInViewsConsidering: 3 ] raise: Error withExceptionDo: [ :error | self assert: error messageText equals: 'More than one valid model was found' ].

	self assertModelAssembledBy: creator equals: 99
]

{ #category : #tests }
ModelMultiplexerTest >> testChangingModelToValidOption [

	| multiplexer |

	multiplexer := ModelMultiplexer multiplexing: (Array with: (self newFixedCreatorFor: 1) with: (self newFixedCreatorFor: $A)) selectingFrom: picker.
	picker updateModelInViewsConsidering: '1'.

	self assertModelAssembledBy: multiplexer equals: 1.

	multiplexer updateModelInViewsConsidering: $A.
	self assertModelAssembledBy: multiplexer equals: $A
]

{ #category : #tests }
ModelMultiplexerTest >> testModelChangesWhenViewSelectionChanges [

	| multiplexer |

	multiplexer := ModelMultiplexer multiplexing: (Array with: (self newFixedCreatorFor: 150) with: (self newFixedCreatorFor: 232)) selectingFrom: picker.

	singleSelectionView chooseElementAt: 1.
	self assertModelAssembledBy: multiplexer equals: 150.

	singleSelectionView chooseElementAt: 2.
	self assertModelAssembledBy: multiplexer equals: 232
]

{ #category : #tests }
ModelMultiplexerTest >> testModelWhenActiveBranchFail [

	| multiplexer |

	multiplexer := ModelMultiplexer multiplexing: (Array with: (self newSingleModelPickerNamed: 'Discount') with: (self newFixedCreatorFor: 232)) selectingFrom: picker.

	singleSelectionView chooseElementAt: 1.
	self assertModelCreationFailedFor: multiplexer
]

{ #category : #tests }
ModelMultiplexerTest >> testModelWhenInactiveBranchFail [

	| multiplexer |

	multiplexer := ModelMultiplexer multiplexing: (Array with: (self newSingleModelPickerNamed: 'Discount') with: (self newFixedCreatorFor: 232)) selectingFrom: picker.

	singleSelectionView chooseElementAt: 2.
	self assertModelAssembledBy: multiplexer  equals: 232
]
