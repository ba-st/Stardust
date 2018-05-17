tests
testCreationIsNotAllowedWhenThereIsNoSelection

	| creator |

	creator := SingleModelPicker
		named: 'selection'
		obtainingSelectionFrom: SingleSelectionViewExample new.

	self should: [ creator modelIn: self ] raise: InstanceCreationFailed