accessing
changeModelTo: aModel in: aContext

	aContext changeModelFor: creator to: (formatter format: aModel)