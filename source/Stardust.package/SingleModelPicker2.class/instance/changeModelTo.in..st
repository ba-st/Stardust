accessing
changeModelTo: anOption in: aContext

	view
		chooseAnySatisfying: [ :element | pickingPolicy is: element equalTo: anOption ]
		ifNone: [ ObjectNotFound2 signal: ('<1p> is not a valid option' expandMacrosWith: anOption) ]