"
I'm a test case
"
Class {
	#name : #SingleModelPickerTest,
	#superclass : #ModelCreatorTest,
	#category : #'Stardust-Tests-ModelCreation'
}

{ #category : #'private - accessing' }
SingleModelPickerTest >> selectableModelFor: aModel [

	^ UISelectableModel representing: aModel with: aModel asString
]

{ #category : #tests }
SingleModelPickerTest >> testAfterChangeOfSelectionModelObtainedRepresentsNewSelection [

	| view creator |

	view := self singleSelectionView.
	creator := SingleModelPicker named: 'Letter' pickingFrom: view.
	creator allowAnyOf: #(G).
	view chooseElementAt: 1.
	self assert: (creator modelIn: context) equals: #G
]

{ #category : #tests }
SingleModelPickerTest >> testAfterChangeOfSelectionModelPreviouslyObtainedIsUnaffected [

	| view previousModel creator |

	view := self singleSelectionView.
	creator := SingleModelPicker named: 'Letter' pickingFrom: view.
	creator allowAnyOf: #(C G).
	view chooseElementAt: 1.
	previousModel := creator modelIn: context.
	view chooseElementAt: 2.
	self assert: previousModel equals: #C
]

{ #category : #tests }
SingleModelPickerTest >> testChangeOfSelectionIsNotAllowedIfSelectionIsNotAnAvailableOption [

	| creator |

	creator := SingleModelPicker named: 'Letter' pickingFrom: self singleSelectionView.

	self should: [ creator changeModelTo: #D in: context ] raise: ObjectNotFound.

	creator allowAnyOf: #(A).
	self should: [ creator changeModelTo: #D in: context ] raise: ObjectNotFound
]

{ #category : #tests }
SingleModelPickerTest >> testCreationIsNotAllowedWhenThereIsNoSelection [

	| creator |

	creator := SingleModelPicker named: 'Letter' pickingFrom: self singleSelectionView.

	self should: [ creator modelIn: context ] raise: ModelCreationFailed
]

{ #category : #tests }
SingleModelPickerTest >> testModelIsTheSameAsViewSelection [

	| view creator |

	view := self singleSelectionView.
	creator := SingleModelPicker named: 'Letter' pickingFrom: view.

	creator allowAnyOf: #(A B C).
	creator changeModelTo: #B in: context.
	self
		assert: (creator modelIn: context) equals: #B;
		assert: view chosenIndex equals: 2.

	view chooseElementAt: 2.
	self assert: (creator modelIn: context) equals: #B.

	creator changeModelTo: #C in: context.
	self assert: view chosenIndex equals: 3
]

{ #category : #tests }
SingleModelPickerTest >> testSelectionIsKeptIfIncludedInNewOptions [

	| view creator |

	view := self singleSelectionView.
	creator := SingleModelPicker named: 'Letters' pickingFrom: view.

	creator allowAnyOf: #(A B C).
	view chooseElementAt: 2.
	self assert: (creator modelIn: context) equals: #B.

	creator allowAnyOf: #(X B Z).
	self assert: (creator modelIn: context) equals: #B
]

{ #category : #tests }
SingleModelPickerTest >> testSelectionIsLostIfNotIncludedInNewOptions [

	| view creator |

	view := self singleSelectionView.
	creator := SingleModelPicker named: 'Letter' pickingFrom: view.

	creator allowAnyOf: #(A B C).
	view chooseElementAt: 2.

	self assert: (creator modelIn: context) equals: #B.

	creator allowAnyOf: #(D J L).
	self should: [ creator modelIn: context ] raise: ModelCreationFailed
]

{ #category : #tests }
SingleModelPickerTest >> testSelectionIsLostIfOptionsAreCleared [

	| view creator |

	view := self singleSelectionView.
	creator := SingleModelPicker named: 'Letter' pickingFrom: view.
	creator allowAnyOf: #(A B C).

	"Simulate the user is selecting the second option"
	view chooseElementAt: 2.

	self assert: (creator modelIn: context) equals: #B.

	creator disallowAll.
	self should: [ creator modelIn: context ] raise: ModelCreationFailed
]
