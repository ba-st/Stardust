tests
testSelectionIsLostIfOptionsAreCleared

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