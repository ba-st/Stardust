tests
testAfterChangeOfSelectionModelObtainedRepresentsNewSelection

	| view creator |

	view := MultipleSelectionViewExample new.
	creator := MultipleModelPicker named: 'selection' obtainingSelectionFrom: view.
	creator allowAnyOf: (Array with: (self selectableModelFor: 3) with: (self selectableModelFor: 4) with: (self selectableModelFor: 6)).
	view chooseElementsAtAll: #(1 2).
	self assert: (creator modelIn: self) equals: #(3 4)