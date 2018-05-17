private - accessing
modelFor: aSingleModelPicker

	^ view currentSelectionIfNone: [ self fail ]