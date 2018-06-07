"
I'm a test case
"
Class {
	#name : #ModelMultiplexerTest,
	#superclass : #ModelCreatorTest,
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
ModelMultiplexerTest >> testCanCreate [

	| creator |

	creator := ModelMultiplexer multiplexing: (Array with: (FixedModelCreator creating: 1) with: (FixedModelCreator creating: $A)) selectingFrom: picker.

	self
		assert: (creator canCreate: 1);
		assert: (creator canCreate: $A);
		deny: (creator canCreate: 3);
		deny: (creator canCreate: 'ZZ')
]

{ #category : #tests }
ModelMultiplexerTest >> testChangingModelToInvalidOptionRaisesError [

	| creator |

	creator := ModelMultiplexer multiplexing: (Array with: (FixedModelCreator creating: 1) with: (FixedModelCreator creating: $A)) selectingFrom: picker.

	context changeModelFor: picker to: '1'.

	self assert: (creator modelIn: context) equals: 1.

	self should: [ creator changeModelTo: 3 in: self ] raise: Error withExceptionDo: [ :error | self assert: error messageText equals: 'More than one valid model was found' ].

	self assert: (creator modelIn: context) equals: 1
]

{ #category : #tests }
ModelMultiplexerTest >> testChangingModelToValidOption [

	| multiplexer |

	multiplexer := ModelMultiplexer multiplexing: (Array with: (FixedModelCreator creating: 1) with: (FixedModelCreator creating: $A)) selectingFrom: picker.
	context changeModelFor: picker to: '1'.

	self assert: (multiplexer modelIn: self) equals: 1.

	context changeModelFor: multiplexer to: $A.
	self assert: (multiplexer modelIn: self) equals: $A
]

{ #category : #tests }
ModelMultiplexerTest >> testModelChangesWhenViewSelectionChanges [

	| creator |

	creator := ModelMultiplexer multiplexing: (Array with: (FixedModelCreator creating: 150) with: (FixedModelCreator creating: 232)) selectingFrom: picker.

	singleSelectionView chooseElementAt: 1.
	self assert: (creator modelIn: self) equals: 150.

	singleSelectionView chooseElementAt: 2.
	self assert: (creator modelIn: self) equals: 232
]
