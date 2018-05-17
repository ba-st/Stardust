tests
testCreationIsNotAllowedWhenThereIsNoSelection

	| creator |

	creator := SingleModelPicker2 named: 'selection' obtainingSelectionFrom: SingleSelectionViewExample new.
	self should: [ creator modelIn: self ] raise: ModelCreationFailed