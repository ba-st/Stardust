instance creation
signalOf: aCreator dueTo: aSignal

	| failuresByCreatorDictionary |

	failuresByCreatorDictionary := Dictionary new
		at: aCreator put: ('<1s>: <2s>' expandMacrosWith: aCreator name with: aSignal userAwareDescription);
		yourself.

	self signalObtainedFrom: failuresByCreatorDictionary