tests
testChangeOfSelectionIsNotAllowedIfSelectionIncludesAnUnavailableOption

	| creator |

	creator := MultipleModelPicker named: 'selection' obtainingSelectionFrom: MultipleSelectionViewExample new.
	self should: [ creator changeModelTo: #(1 2) in: self ] raise: ProgrammingError