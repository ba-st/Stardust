initialization
initializeParsing: aString explainedByAll: failureExplanations

	self tag: aString.
	failures := failureExplanations.