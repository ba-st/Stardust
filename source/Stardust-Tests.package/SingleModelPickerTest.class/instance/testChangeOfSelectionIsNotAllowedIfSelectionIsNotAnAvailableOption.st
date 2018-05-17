tests
testChangeOfSelectionIsNotAllowedIfSelectionIsNotAnAvailableOption

	| creator |

	creator := SingleModelPicker named: 'selection' obtainingSelectionFrom: SingleSelectionViewExample new.
	self should: [ creator changeModelTo: 4 in: self ] raise: ObjectNotFound.
	creator allowAnyOf: (Array with: (self selectableModelFor: 1)).
	self should: [ creator changeModelTo: 4 in: self ] raise: ObjectNotFound