"
I'm an unit test for BinaryChoiceModelPicker
"
Class {
	#name : #BinaryChoiceModelPickerTest,
	#superclass : #ModelCreatorTest,
	#category : #'Stardust-Tests-ModelCreation'
}

{ #category : #tests }
BinaryChoiceModelPickerTest >> testAccessing [

	| picker |

	picker := BinaryChoiceModelPicker named: 'Toggle' obtainingSelectionFrom: (DummyToggleView onModel: 'ON' offModel: 'OFF').

	self assert: picker name equals: 'Toggle'
]

{ #category : #tests }
BinaryChoiceModelPickerTest >> testCanCreate [

	| picker |

	picker := BinaryChoiceModelPicker named: 'Toggle' obtainingSelectionFrom: (DummyToggleView onModel: 'ON' offModel: 'OFF').

	self
		assert: (picker canCreate: 'ON');
		assert: (picker canCreate: 'OFF');
		deny: (picker canCreate: 'ONOFF')
]

{ #category : #tests }
BinaryChoiceModelPickerTest >> testChangeModelTo [

	| picker |

	picker := BinaryChoiceModelPicker named: 'Toggle' obtainingSelectionFrom: (DummyToggleView onModel: 'ON' offModel: 'OFF').

	self assertModelAssembledBy: picker equals: 'OFF'.

	picker updateModelInViewsConsidering: 'ON'.
	self assertModelAssembledBy: picker equals: 'ON'.

	picker updateModelInViewsConsidering: 'ON'.
	self assertModelAssembledBy: picker equals: 'ON'.

	picker updateModelInViewsConsidering: 'OFF'.
	self assertModelAssembledBy: picker equals: 'OFF'.

	picker updateModelInViewsConsidering: 'ON'.
	self assertModelAssembledBy: picker equals: 'ON'
]

{ #category : #tests }
BinaryChoiceModelPickerTest >> testChangeModelToInvalidOption [

	| picker |

	picker := BinaryChoiceModelPicker
		named: 'Toggle'
		obtainingSelectionFrom: ( DummyToggleView onModel: 'ON' offModel: 'OFF' ).

	self assertModelAssembledBy: picker equals: 'OFF'.

	self
		should: [ picker updateModelInViewsConsidering: 'UNKNOWN' ]
		raise: ObjectNotFound
		withMessageText: 'UNKNOWN is not a valid option'
]

{ #category : #tests }
BinaryChoiceModelPickerTest >> testModelToggling [

	| picker toggle |

	toggle := DummyToggleView onModel: 'ON' offModel: 'OFF'.

	picker := BinaryChoiceModelPicker
		named: 'Toggle'
		obtainingSelectionFrom: toggle.

	self assertModelAssembledBy: picker equals: 'OFF'.

	toggle toggleCurrentSelection.
	self assertModelAssembledBy: picker equals: 'ON'.

	toggle toggleCurrentSelection.
	self assertModelAssembledBy: picker equals: 'OFF'.

	toggle toggleCurrentSelection.
	self assertModelAssembledBy: picker equals: 'ON'
]
