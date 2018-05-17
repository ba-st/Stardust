accessing
modelInSequenceFor: aCreator

	^ knownModels at: aCreator ifAbsentPut: [ aCreator modelIn: self ]