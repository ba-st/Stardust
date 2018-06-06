Class {
	#name : #ModelMultiplexerTest,
	#superclass : #TestCase,
	#instVars : [
		'view'
	],
	#category : #'Stardust-Tests-ModelCreation'
}

{ #category : #'private - accessing' }
ModelMultiplexerTest >> modelFor: aSingleModelPicker [

	^ view currentSelectionIfNone: [ self fail ]
]

{ #category : #running }
ModelMultiplexerTest >> setUp [

	super setUp.
	view := DummySingleSelectionView new
]

{ #category : #'private - accessing' }
ModelMultiplexerTest >> singleModelPicker [

	^ SingleModelPicker named: 'Test' pickingFrom: view
]

{ #category : #tests }
ModelMultiplexerTest >> testCanCreate [

	| creator |

	creator := ModelMultiplexer
		multiplexing:
			(Array
				with: (FixedModelCreator creating: 1)
				with: (FixedModelCreator creating: 2))
		selectingFrom: self singleModelPicker.

	self
		assert: (creator canCreate: 1);
		assert: (creator canCreate: 2);
		deny: (creator canCreate: 3)
]

{ #category : #tests }
ModelMultiplexerTest >> testChangingModelToInvalidOptionRaisesError [

	| creator |

	creator := ModelMultiplexer multiplexing: (Array with: (FixedModelCreator creating: 1) with: (FixedModelCreator creating: 2)) selectingFrom: self singleModelPicker.
	view chooseElementAt: 1.

	self assert: (creator modelIn: self) equals: 1.
	self should: [ creator changeModelTo: 3 in: self ] raise: Error withExceptionDo: [ :error | self assert: error messageText equals: 'More than one vaid model was found' ].
	self assert: (creator modelIn: self) equals: 1
]

{ #category : #tests }
ModelMultiplexerTest >> testChangingModelToValidOption [

	| creator |

	creator := ModelMultiplexer
		multiplexing:
			(Array
				with: (FixedModelCreator creating: 1)
				with: (FixedModelCreator creating: 2))
		selectingFrom: self singleModelPicker.

	view chooseElementAt: 1.
	self assert: (creator modelIn: self) equals: 1.

	creator changeModelTo: 2 in: self.
	self assert: (creator modelIn: self) equals: 2
]

{ #category : #tests }
ModelMultiplexerTest >> testModelChangesWhenViewSelectionChanges [

	| creator |

	creator := ModelMultiplexer
		multiplexing:
			(Array
				with: (FixedModelCreator creating: 150)
				with: (FixedModelCreator creating: 232))
		selectingFrom: self singleModelPicker.

	view chooseElementAt: 1.
	self assert: (creator modelIn: self) equals: 150.

	view chooseElementAt: 2.
	self assert: (creator modelIn: self) equals: 232
]
