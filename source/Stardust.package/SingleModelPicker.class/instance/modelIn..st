accessing
modelIn: aContext

	^ pickingPolicy
		pickFrom:
			(view
				currentSelectionIfNone: [ InstanceCreationFailed signal: #'You must select a valid element' ])