tests
testChangingModelThroughCreatorChangesViewContents

	| cornerXView cornerYView cornerCreator supervisor |

	cornerXView := TextInputViewExample new.
	cornerYView := TextInputViewExample new.
	cornerCreator := self pointCreatorFrom: cornerXView and: cornerYView.
	supervisor := ModelCreationSupervisor supervising: cornerCreator.
	supervisor changeModelTo: 2 @ 3.
	self assert: cornerXView contents equals: '2'.
	self assert: cornerYView contents equals: '3'