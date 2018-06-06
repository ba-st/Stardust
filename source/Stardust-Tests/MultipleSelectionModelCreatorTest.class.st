"
I'm a test case
"
Class {
	#name : #MultipleSelectionModelCreatorTest,
	#superclass : #TestCase,
	#category : #'Stardust-Tests-ModelCreation'
}

{ #category : #'private - accessing' }
MultipleSelectionModelCreatorTest >> selectableModelFor: aModel [

	^ UISelectableModel representing: aModel with: aModel asString
]

{ #category : #tests }
MultipleSelectionModelCreatorTest >> testAfterChangeOfSelectionModelObtainedRepresentsNewSelection [

	| view creator |

	view := DummyMultipleSelectionView new.
	creator := MultipleModelPicker named: 'selection' obtainingSelectionFrom: view.
	creator allowAnyOf: (Array with: (self selectableModelFor: 3) with: (self selectableModelFor: 4) with: (self selectableModelFor: 6)).
	view chooseElementsAtAll: #(1 2).
	self assert: (creator modelIn: self) equals: #(3 4)
]

{ #category : #tests }
MultipleSelectionModelCreatorTest >> testAfterChangeOfSelectionModelPreviouslyObtainedIsUnaffected [

	| view previousModel creator |

	view := DummyMultipleSelectionView new.
	creator := MultipleModelPicker named: 'selection' obtainingSelectionFrom: view.
	creator
		allowAnyOf:
			(Array
				with: (self selectableModelFor: 2)
				with: (self selectableModelFor: 4)
				with: (self selectableModelFor: 6)
				with: (self selectableModelFor: 8)).
	view chooseElementsAtAll: #(1 2).
	previousModel := creator modelIn: self.
	view chooseElementsAtAll: #(3 4).
	self assert: previousModel equals: #(2 4)
]

{ #category : #tests }
MultipleSelectionModelCreatorTest >> testChangeOfSelectionIsNotAllowedIfSelectionIncludesAnUnavailableOption [

	| creator |

	creator := MultipleModelPicker
		named: 'selection'
		obtainingSelectionFrom: DummyMultipleSelectionView new.
	self should: [ creator changeModelTo: #(1 2) in: self ] raise: ObjectNotFound
]

{ #category : #tests }
MultipleSelectionModelCreatorTest >> testEmptyCollectionIsObtainedWhenThereIsNoSelection [

	| creator |

	creator := MultipleModelPicker named: 'selection' obtainingSelectionFrom: DummyMultipleSelectionView new.
	self assert: (creator modelIn: self) isEmpty
]

{ #category : #tests }
MultipleSelectionModelCreatorTest >> testModelIsTheSameAsViewSelection [

	| view creator |

	view := DummyMultipleSelectionView new.
	creator := MultipleModelPicker named: 'selection' obtainingSelectionFrom: view.
	creator
		allowAnyOf:
			(Array
				with: (self selectableModelFor: 2)
				with: (self selectableModelFor: 4)
				with: (self selectableModelFor: 6)
				with: (self selectableModelFor: 8)).
	creator changeModelTo: #(2 6) in: self.
	self assert: (creator modelIn: self) equals: #(2 6).
	view chooseElementsAtAll: #(1 2).
	self assert: (creator modelIn: self) equals: #(2 4).
	creator changeModelTo: #(2 6) in: self.
	self assert: view chosenIndexes equals: #(1 3)
]

{ #category : #tests }
MultipleSelectionModelCreatorTest >> testSelectionIsKeptIfCompletelyIncludedInNewOptions [

	| view creator |

	view := DummyMultipleSelectionView new.
	creator := MultipleModelPicker named: 'selection' obtainingSelectionFrom: view.
	creator allowAnyOf: (Array with: (self selectableModelFor: 2) with: (self selectableModelFor: 4) with: (self selectableModelFor: 6)).
	view chooseElementsAtAll: #(1 2).
	self assert: (creator modelIn: self) equals: #(2 4).
	creator
		allowAnyOf:
			(Array
				with: (self selectableModelFor: 5)
				with: (self selectableModelFor: 7)
				with: (self selectableModelFor: 4)
				with: (self selectableModelFor: 2)).
	self assert: (creator modelIn: self) equals: #(2 4)
]

{ #category : #tests }
MultipleSelectionModelCreatorTest >> testSelectionIsLostIfNotCompletelyIncludedInNewOptions [

	| view creator |

	view := DummyMultipleSelectionView new.
	creator := MultipleModelPicker named: 'selection' obtainingSelectionFrom: view.
	creator allowAnyOf: (Array with: (self selectableModelFor: 2) with: (self selectableModelFor: 4) with: (self selectableModelFor: 6)).
	view chooseElementsAtAll: #(1 2).
	self assert: (creator modelIn: self) equals: #(2 4).
	creator
		allowAnyOf:
			(Array
				with: (self selectableModelFor: 5)
				with: (self selectableModelFor: 7)
				with: (self selectableModelFor: 6)
				with: (self selectableModelFor: 1)).
	self assert: (creator modelIn: self) isEmpty
]

{ #category : #tests }
MultipleSelectionModelCreatorTest >> testSelectionIsLostIfOptionsAreCleared [

	| view creator |

	view := DummyMultipleSelectionView new.
	creator := MultipleModelPicker named: 'selection' obtainingSelectionFrom: view.
	creator allowAnyOf: (Array with: (self selectableModelFor: 2) with: (self selectableModelFor: 4) with: (self selectableModelFor: 6)).
	view chooseElementsAtAll: #(1 2).
	self assert: (creator modelIn: self) equals: #(2 4).
	creator disallowAll.
	self assert: (creator modelIn: self) isEmpty
]
