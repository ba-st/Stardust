Class {
	#name : #SingleModelPickerTest,
	#superclass : #TestCase,
	#category : 'Stardust-Tests-ModelCreator'
}

{ #category : #'private - accessing' }
SingleModelPickerTest >> selectableModelFor: aModel [

	^ UISelectableModel representing: aModel with: aModel asString
]

{ #category : #tests }
SingleModelPickerTest >> testAfterChangeOfSelectionModelObtainedRepresentsNewSelection [

	| view creator |

	view := SingleSelectionViewExample new.
	creator := SingleModelPicker
		named: 'selection'
		obtainingSelectionFrom: view.
	creator allowAnyOf: (Array with: (self selectableModelFor: 7)).
	view chooseElementAt: 1.
	self assert: (creator modelIn: self) equals: 7
]

{ #category : #tests }
SingleModelPickerTest >> testAfterChangeOfSelectionModelPreviouslyObtainedIsUnaffected [

	| view previousModel creator |

	view := SingleSelectionViewExample new.
	creator := SingleModelPicker
		named: 'selection'
		obtainingSelectionFrom: view.
	creator
		allowAnyOf:
			(Array
				with: (self selectableModelFor: 3)
				with: (self selectableModelFor: 7)).
	view chooseElementAt: 1.
	previousModel := creator modelIn: self.
	view chooseElementAt: 2.
	self assert: previousModel equals: 3
]

{ #category : #tests }
SingleModelPickerTest >> testChangeOfSelectionIsNotAllowedIfSelectionIsNotAnAvailableOption [

	| creator |

	creator := SingleModelPicker named: 'selection' obtainingSelectionFrom: SingleSelectionViewExample new.
	self should: [ creator changeModelTo: 4 in: self ] raise: ObjectNotFound.
	creator allowAnyOf: (Array with: (self selectableModelFor: 1)).
	self should: [ creator changeModelTo: 4 in: self ] raise: ObjectNotFound
]

{ #category : #tests }
SingleModelPickerTest >> testCreationIsNotAllowedWhenThereIsNoSelection [

	| creator |

	creator := SingleModelPicker named: 'selection' obtainingSelectionFrom: SingleSelectionViewExample new.
	self should: [ creator modelIn: self ] raise: ModelCreationFailed
]

{ #category : #tests }
SingleModelPickerTest >> testModelIsTheSameAsViewSelection [

	| view creator |

	view := SingleSelectionViewExample new.
	creator := SingleModelPicker
		named: 'selection'
		obtainingSelectionFrom: view.
	creator
		allowAnyOf:
			(Array
				with: (self selectableModelFor: 1)
				with: (self selectableModelFor: 3)
				with: (self selectableModelFor: 5)).
	creator changeModelTo: 5 in: self.
	self assert: (creator modelIn: self) equals: 5.
	view chooseElementAt: 2.
	self assert: (creator modelIn: self) equals: 3.
	creator changeModelTo: 5 in: self.
	self assert: view chosenIndex equals: 3
]

{ #category : #tests }
SingleModelPickerTest >> testSelectionIsKeptIfIncludedInNewOptions [

	| view creator |

	view := SingleSelectionViewExample new.
	creator := SingleModelPicker
		named: 'selection'
		obtainingSelectionFrom: view.
	creator
		allowAnyOf:
			(Array
				with: (self selectableModelFor: 1)
				with: (self selectableModelFor: 2)
				with: (self selectableModelFor: 3)).
	view chooseElementAt: 2.
	self assert: (creator modelIn: self) equals: 2.
	creator
		allowAnyOf:
			(Array
				with: (self selectableModelFor: 2)
				with: (self selectableModelFor: 6)
				with: (self selectableModelFor: 9)).
	self assert: (creator modelIn: self) equals: 2
]

{ #category : #tests }
SingleModelPickerTest >> testSelectionIsLostIfNotIncludedInNewOptions [

	| view creator |

	view := SingleSelectionViewExample new.
	creator := SingleModelPicker named: 'selection' obtainingSelectionFrom: view.
	creator
		allowAnyOf:
			(Array
				with: (self selectableModelFor: 1)
				with: (self selectableModelFor: 2)
				with: (self selectableModelFor: 3)).
	view chooseElementAt: 2.
	self assert: (creator modelIn: self) equals: 2.
	creator
		allowAnyOf:
			(Array
				with: (self selectableModelFor: 1)
				with: (self selectableModelFor: 6)
				with: (self selectableModelFor: 9)).
	self should: [ creator modelIn: self ] raise: ModelCreationFailed
]

{ #category : #tests }
SingleModelPickerTest >> testSelectionIsLostIfOptionsAreCleared [

	| view creator |

	view := SingleSelectionViewExample new.
	creator := SingleModelPicker named: 'selection' obtainingSelectionFrom: view.
	creator
		allowAnyOf:
			(Array
				with: (self selectableModelFor: 1)
				with: (self selectableModelFor: 2)
				with: (self selectableModelFor: 3)).
	view chooseElementAt: 2.
	self assert: (creator modelIn: self) equals: 2.
	creator disallowAll.
	self should: [ creator modelIn: self ] raise: ModelCreationFailed
]
