accessing
changeModelFor: aCreator to: aModel

	knownModels at: aCreator put: aModel.
	aCreator changeModelTo: aModel in: self