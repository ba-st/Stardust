tests
testChangeOfSelectionIsNotAllowedIfSelectionIsNotAnAvailableOption

	| creator |

	creator := SingleModelPicker2
		named: 'selection'
		obtainingSelectionFrom: SingleSelectionViewExample2 new.

	self should: [ creator changeModelTo: 4 in: self ] raise: ObjectNotFound2.

	creator allowAnyOf: (Array with: (self selectableModelFor: 1)).

	self should: [ creator changeModelTo: 4 in: self ] raise: ObjectNotFound2