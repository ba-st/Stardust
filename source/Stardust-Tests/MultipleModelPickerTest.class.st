"
I'm a test case
"
Class {
	#name : #MultipleModelPickerTest,
	#superclass : #ModelCreatorTest,
	#category : #'Stardust-Tests-ModelCreation'
}

{ #category : #tests }
MultipleModelPickerTest >> testAfterChangeOfSelectionModelObtainedRepresentsNewSelection [

	| view picker |

	view := self newMultipleSelectionView.
	picker := MultipleModelPicker named: 'Letters' pickingFrom: view.
	picker allowAnyOf: #(A B C).
	view chooseElementsAtAll: #(1 2).
	self assertModelAssembledBy: picker equals: #(A B)
]

{ #category : #tests }
MultipleModelPickerTest >> testCanCreate [

	| view picker |

	view := self newMultipleSelectionView.
	picker := MultipleModelPicker named: 'Letters' pickingFrom: view.

	self
		assert: (picker canCreate: #());
		deny: (picker canCreate: #(A)).

	picker allowAnyOf: #(A B C).

	self
		assert: (picker canCreate: #(A B C));
		assert: (picker canCreate: #(A B));
		assert: (picker canCreate: #(A));
		assert: (picker canCreate: #(C))
]

{ #category : #tests }
MultipleModelPickerTest >> testChangeOfSelectionIsNotAllowedIfSelectionIncludesAnUnavailableOption [

	| picker |

	picker := MultipleModelPicker named: 'Letters' pickingFrom: self newMultipleSelectionView.
	self should: [ picker updateModelInViewsConsidering: #(A B) ] raise: ObjectNotFound
]

{ #category : #tests }
MultipleModelPickerTest >> testEmptyCollectionIsObtainedWhenThereIsNoSelection [

	| picker |

	picker := MultipleModelPicker named: 'Letters' pickingFrom: self newMultipleSelectionView.
	self assertModelAssembledBy: picker equals: #()
]

{ #category : #tests }
MultipleModelPickerTest >> testModelIsTheSameAsViewSelection [

	| view picker |

	view := self newMultipleSelectionView.
	picker := MultipleModelPicker named: 'Letters' pickingFrom: view.
	picker allowAnyOf: #(A B C D).

	picker updateModelInViewsConsidering: #(A C).
	self assertModelAssembledBy: picker equals: #(A C).

	view chooseElementsAtAll: #(1 2).
	self assertModelAssembledBy: picker equals: #(A B).

	picker updateModelInViewsConsidering: #(A C).
	self assert: view chosenIndexes equals: #(1 3)
]

{ #category : #tests }
MultipleModelPickerTest >> testSelectionIsKeptIfCompletelyIncludedInNewOptions [

	| view picker |

	view := self newMultipleSelectionView.
	picker := MultipleModelPicker named: 'Letters' pickingFrom: view.
	picker allowAnyOf: #(A B C).
	view chooseElementsAtAll: #(1 2).
	self assertModelAssembledBy: picker equals: #(A B).

	picker allowAnyOf: #(D E F A B).
	self assertModelAssembledBy: picker equals: #(A B)
]

{ #category : #tests }
MultipleModelPickerTest >> testSelectionIsLostIfNotCompletelyIncludedInNewOptions [

	| view picker |

	view := self newMultipleSelectionView.
	picker := MultipleModelPicker named: 'Letters' pickingFrom: view.
	picker allowAnyOf: #(A B C).
	view chooseElementsAtAll: #(1 2).
	self assertModelAssembledBy: picker equals: #(A B).

	picker allowAnyOf: #(D E F A).
	self assertModelAssembledBy: picker equals: #()
]

{ #category : #tests }
MultipleModelPickerTest >> testSelectionIsLostIfOptionsAreCleared [

	| view picker |

	view := self newMultipleSelectionView.
	picker := MultipleModelPicker named: 'selection' pickingFrom: view.
	picker allowAnyOf: #(B D F).

	view chooseElementsAtAll: #(1 2).
	self assertModelAssembledBy: picker equals: #(B D).

	picker disallowAll.
	self assertModelAssembledBy: picker equals: #()
]
