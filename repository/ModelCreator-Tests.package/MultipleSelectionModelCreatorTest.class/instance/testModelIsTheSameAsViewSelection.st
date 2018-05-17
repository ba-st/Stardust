tests
testModelIsTheSameAsViewSelection

	| view creator |

	view := MultipleSelectionViewExample new.
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