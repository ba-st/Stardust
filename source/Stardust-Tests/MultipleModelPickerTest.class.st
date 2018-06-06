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

	| view creator |

	view := self multipleSelectionView.
	creator := MultipleModelPicker named: 'Letters' pickingFrom: view.
	creator allowAnyOf: #(A B C).
	view chooseElementsAtAll: #(1 2).
	self assert: (creator modelIn: context) equals: #(A B)
]

{ #category : #tests }
MultipleModelPickerTest >> testAfterChangeOfSelectionModelPreviouslyObtainedIsUnaffected [

	| view previousModel creator |

	view := self multipleSelectionView.
	creator := MultipleModelPicker named: 'Letters' pickingFrom: view.
	creator allowAnyOf: #(A B C D).
	view chooseElementsAtAll: #(1 2).
	previousModel := creator modelIn: context.
	view chooseElementsAtAll: #(3 4).
	self assert: previousModel equals: #(A B)
]

{ #category : #tests }
MultipleModelPickerTest >> testCanCreate [

	| view creator |

	view := self multipleSelectionView.
	creator := MultipleModelPicker named: 'Letters' pickingFrom: view.

	self
		assert: (creator canCreate: #());
		deny: (creator canCreate: #(A)).

	creator allowAnyOf: #(A B C).

	self
		assert: (creator canCreate: #(A B C));
		assert: (creator canCreate: #(A B));
		assert: (creator canCreate: #(A));
		assert: (creator canCreate: #(C))
]

{ #category : #tests }
MultipleModelPickerTest >> testChangeOfSelectionIsNotAllowedIfSelectionIncludesAnUnavailableOption [

	| creator |

	creator := MultipleModelPicker named: 'Letters' pickingFrom: self multipleSelectionView.
	self should: [ creator changeModelTo: #(A B) in: self ] raise: ObjectNotFound
]

{ #category : #tests }
MultipleModelPickerTest >> testEmptyCollectionIsObtainedWhenThereIsNoSelection [

	| creator |

	creator := MultipleModelPicker named: 'Letters' pickingFrom: self multipleSelectionView.
	self assert: (creator modelIn: context) isEmpty
]

{ #category : #tests }
MultipleModelPickerTest >> testModelIsTheSameAsViewSelection [

	| view creator |

	view := self multipleSelectionView.
	creator := MultipleModelPicker named: 'Letters' pickingFrom: view.
	creator allowAnyOf: #(A B C D).

	creator changeModelTo: #(A C) in: context.
	self assert: (creator modelIn: context) equals: #(A C).

	view chooseElementsAtAll: #(1 2).
	self assert: (creator modelIn: context) equals: #(A B).

	creator changeModelTo: #(A C) in: context.
	self assert: view chosenIndexes equals: #(1 3)
]

{ #category : #tests }
MultipleModelPickerTest >> testSelectionIsKeptIfCompletelyIncludedInNewOptions [

	| view creator |

	view := self multipleSelectionView.
	creator := MultipleModelPicker named: 'Letters' pickingFrom: view.
	creator allowAnyOf: #(A B C).
	view chooseElementsAtAll: #(1 2).
	self assert: (creator modelIn: context) equals: #(A B).

	creator allowAnyOf: #(D E F A B).
	self assert: (creator modelIn: context) equals: #(A B)
]

{ #category : #tests }
MultipleModelPickerTest >> testSelectionIsLostIfNotCompletelyIncludedInNewOptions [

	| view creator |

	view := self multipleSelectionView.
	creator := MultipleModelPicker named: 'Letters' pickingFrom: view.
	creator allowAnyOf: #(A B C).
	view chooseElementsAtAll: #(1 2).
	self assert: (creator modelIn: context) equals: #(A B).

	creator allowAnyOf: #(D E F A).
	self assert: (creator modelIn: context) isEmpty
]

{ #category : #tests }
MultipleModelPickerTest >> testSelectionIsLostIfOptionsAreCleared [

	| view creator |

	view := self multipleSelectionView.
	creator := MultipleModelPicker named: 'selection' pickingFrom: view.
	creator allowAnyOf: #(B D F).

	view chooseElementsAtAll: #(1 2).
	self assert: (creator modelIn: context) equals: #(B D).

	creator disallowAll.
	self assert: (creator modelIn: context) isEmpty
]
