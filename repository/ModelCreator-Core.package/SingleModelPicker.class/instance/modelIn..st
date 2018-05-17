accessing
modelIn: aContext

	^ pickingPolicy pickFrom: (view currentSelectionIfNone: [ ModelCreationFailed signal: 'A valid element must be selected' ])