tests
testAfterChangeOfSelectionModelPreviouslyObtainedIsUnaffected

	| view previousModel creator |

	view := MultipleSelectionViewExample new.
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