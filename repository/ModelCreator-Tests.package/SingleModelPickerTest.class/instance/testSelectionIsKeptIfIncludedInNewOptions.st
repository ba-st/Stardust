tests
testSelectionIsKeptIfIncludedInNewOptions

	| view creator |

	view := SingleSelectionViewExample new.
	creator := SingleModelPicker named: 'selection' obtainingSelectionFrom: view.
	creator allowAnyOf: (Array with: (self selectableModelFor: 1) with: (self selectableModelFor: 2) with: (self selectableModelFor: 3)).
	view chooseElementAt: 2.
	self assert: (creator modelIn: self) equals: 2.
	creator allowAnyOf: (Array with: (self selectableModelFor: 2) with: (self selectableModelFor: 6) with: (self selectableModelFor: 9)).
	self assert: (creator modelIn: self) equals: 2