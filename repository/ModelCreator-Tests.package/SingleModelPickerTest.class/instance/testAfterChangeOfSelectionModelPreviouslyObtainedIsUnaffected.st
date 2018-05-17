tests
testAfterChangeOfSelectionModelPreviouslyObtainedIsUnaffected

	| view previousModel creator |

	view := SingleSelectionViewExample new.
	creator := SingleModelPicker named: 'selection' obtainingSelectionFrom: view.
	creator allowAnyOf: (Array with: (self selectableModelFor: 3) with: (self selectableModelFor: 7)).
	view chooseElementAt: 1.
	previousModel := creator modelIn: self.
	view chooseElementAt: 2.
	self assert: previousModel equals: 3