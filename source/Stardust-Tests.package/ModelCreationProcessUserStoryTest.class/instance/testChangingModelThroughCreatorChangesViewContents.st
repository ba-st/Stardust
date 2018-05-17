tests
testChangingModelThroughCreatorChangesViewContents

	| cornerXView cornerYView cornerCreator supervisor |

	cornerXView := self textInputView.
	cornerYView := self textInputView.
	cornerCreator := self pointCreatorFrom: cornerXView and: cornerYView.
	
	supervisor := ModelCreationSupervisor supervising: cornerCreator.
	supervisor changeModelTo: 2 @ 3.
	
	self assert: cornerXView contents equals: '2'.
	self assert: cornerYView contents equals: '3'