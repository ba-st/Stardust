tests
testEmptyCollectionIsObtainedWhenThereIsNoSelection

	| creator |

	creator := MultipleModelPicker named: 'selection' obtainingSelectionFrom: MultipleSelectionViewExample new.
	self assert: (creator modelIn: self) isEmpty