tests
testModelIsTheSameAsViewSelection

	| view creator |

	view := SingleSelectionViewExample new.
	creator := SingleModelPicker named: 'selection' obtainingSelectionFrom: view.
	creator allowAnyOf: (Array with: (self selectableModelFor: 1) with: (self selectableModelFor: 3) with: (self selectableModelFor: 5)).
	creator changeModelTo: 5 in: self.
	self assert: (creator modelIn: self) equals: 5.
	view chooseElementAt: 2.
	self assert: (creator modelIn: self) equals: 3.
	creator changeModelTo: 5 in: self.
	self assert: view chosenIndex equals: 3