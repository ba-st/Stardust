accessing
changeModelTo: anOption in: aContext

	view
		chooseAnySatisfying: [ :element | pickingPolicy is: element equalTo: anOption ]
		ifNone: [ ObjectNotFound signal: ('<1s> is not a valid option' expandMacrosWith: anOption asString) ]