"
I'm a test case
"
Class {
	#name : #SingleModelPickerTest,
	#superclass : #ModelCreatorTest,
	#category : #'Stardust-Tests-ModelCreation'
}

{ #category : #tests }
SingleModelPickerTest >> testAfterChangeOfSelectionModelObtainedRepresentsNewSelection [

	| view picker |

	view := self newSingleSelectionView.
	picker := SingleModelPicker named: 'Letter' pickingFrom: view.
	picker allowAnyOf: #(G).
	view chooseElementAt: 1.
	self assertModelAssembledBy: picker equals: #G
]

{ #category : #tests }
SingleModelPickerTest >> testCanCreate [

	| view picker |

	view := self newSingleSelectionView.
	picker := SingleModelPicker named: 'Letter' pickingFrom: view.
	picker allowAnyOf: #(G).

	self
		assert: (picker canCreate: #G);
		deny: (picker canCreate: #Z)
]

{ #category : #tests }
SingleModelPickerTest >> testChangeOfSelectionIsNotAllowedIfSelectionIsNotAnAvailableOption [

	| picker |

	picker := SingleModelPicker named: 'Letter' pickingFrom: self newSingleSelectionView.

	self should: [ picker updateModelInViewsConsidering: #D ] raise: ObjectNotFound.

	picker allowAnyOf: #(A).
	self should: [ picker updateModelInViewsConsidering: #D ] raise: ObjectNotFound
]

{ #category : #tests }
SingleModelPickerTest >> testCreationIsNotAllowedWhenThereIsNoSelection [

	| picker |

	picker := SingleModelPicker named: 'Letter' pickingFrom: self newSingleSelectionView.

	self assertModelCreationFailedFor: picker
]

{ #category : #tests }
SingleModelPickerTest >> testModelIsTheSameAsViewSelection [

	| view picker |

	view := self newSingleSelectionView.
	picker := SingleModelPicker named: 'Letter' pickingFrom: view.

	picker allowAnyOf: #(A B C).
	picker updateModelInViewsConsidering: #B.
	self
		assertModelAssembledBy: picker equals: #B;
		assert: view chosenIndex equals: 2.

	view chooseElementAt: 2.
	self assertModelAssembledBy: picker equals: #B.

	picker updateModelInViewsConsidering: #C.
	self assert: view chosenIndex equals: 3
]

{ #category : #tests }
SingleModelPickerTest >> testSelectionIsKeptIfIncludedInNewOptions [

	| view picker |

	view := self newSingleSelectionView.
	picker := SingleModelPicker named: 'Letters' pickingFrom: view.

	picker allowAnyOf: #(A B C).
	view chooseElementAt: 2.
	self assertModelAssembledBy: picker equals: #B.

	picker allowAnyOf: #(X B Z).
	self assertModelAssembledBy: picker equals: #B
]

{ #category : #tests }
SingleModelPickerTest >> testSelectionIsLostIfNotIncludedInNewOptions [

	| view picker |

	view := self newSingleSelectionView.
	picker := SingleModelPicker named: 'Letter' pickingFrom: view.

	picker allowAnyOf: #(A B C).
	view chooseElementAt: 2.

	self assertModelAssembledBy: picker equals: #B.

	picker allowAnyOf: #(D J L).
	self assertModelCreationFailedFor: picker
]

{ #category : #tests }
SingleModelPickerTest >> testSelectionIsLostIfOptionsAreCleared [

	| view picker |

	view := self newSingleSelectionView.
	picker := SingleModelPicker named: 'Letter' pickingFrom: view.
	picker allowAnyOf: #(A B C).

	"Simulate the user is selecting the second option"
	view chooseElementAt: 2.

	self assertModelAssembledBy: picker equals: #B.

	picker disallowAll.
	self assertModelCreationFailedFor: picker
]
