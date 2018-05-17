tests
testCreationIsNotAllowedWhenThereIsNoSelection

	| creator |

	creator := SingleModelPicker2
		named: 'selection'
		obtainingSelectionFrom: SingleSelectionViewExample2 new.

	self should: [ creator modelIn: self ] raise: InstanceCreationFailed