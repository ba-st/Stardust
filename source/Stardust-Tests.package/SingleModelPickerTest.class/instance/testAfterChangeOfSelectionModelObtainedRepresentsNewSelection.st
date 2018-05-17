tests
testAfterChangeOfSelectionModelObtainedRepresentsNewSelection

	| view creator |

	view := SingleSelectionViewExample new.
	creator := SingleModelPicker2 named: 'selection' obtainingSelectionFrom: view.
	creator allowAnyOf: (Array with: (self selectableModelFor: 7)).
	view chooseElementAt: 1.
	self assert: (creator modelIn: self) equals: 7