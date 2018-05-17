signalling
signalAll: failureExplanations parsing: aString

	^ (self new initializeParsing: aString explainedByAll: failureExplanations) signal: ('. ' join: failureExplanations)