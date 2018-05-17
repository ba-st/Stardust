tests
testSelectionIsKeptIfCompletelyIncludedInNewOptions

	| view creator |

	view := MultipleSelectionViewExample new.
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