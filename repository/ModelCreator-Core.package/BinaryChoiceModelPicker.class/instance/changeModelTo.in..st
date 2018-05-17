accessing
changeModelTo: anOption in: aContext

	(self canCreate: anOption)
		ifFalse: [ ObjectNotFound signal: ('<1s> is not a valid option' expandMacrosWith: anOption asString) ].

	view currentSelection = anOption
		ifFalse: [ view toggleCurrentSelection ]