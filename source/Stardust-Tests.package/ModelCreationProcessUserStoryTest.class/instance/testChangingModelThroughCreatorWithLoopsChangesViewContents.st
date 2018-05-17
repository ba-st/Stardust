tests
testChangingModelThroughCreatorWithLoopsChangesViewContents

	| originView originPicker cornerXView cornerYView cornerCreator rectangleCreator supervisor |

	originView := SingleSelectionViewExample new.
	originPicker := SingleModelPicker
		named: 'origin'
		obtainingSelectionFrom: originView.
	cornerXView := TextInputViewExample new.
	cornerYView := TextInputViewExample new.
	cornerCreator := self pointCreatorFrom: cornerXView and: cornerYView.
	rectangleCreator := self
		rectangleCreatorFrom: originPicker
		to: cornerCreator.
	supervisor := ModelCreationSupervisor supervising: rectangleCreator.
	originView allowAnyOf: self selectablePoints.
	supervisor changeModelTo: (1 @ 1 corner: 2 @ 3).
	self assert: originView chosenIndex equals: 1.
	self assert: cornerXView contents equals: '2'.
	self assert: cornerYView contents equals: '3'