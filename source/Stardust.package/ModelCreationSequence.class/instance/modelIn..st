accessing
modelIn: aContext

	| failuresByCreator |

	failuresByCreator := Dictionary new.
	orderedCreators
		do: [ :creator | 
			[ [ aContext modelInSequenceFor: creator ]
				on: InstanceCreationFailed
				do: [ :signal | 
					errorDisplayStrategy
						handle: signal
						originatedIn: creator
						storingFailuresOn: failuresByCreator ] ]
				on: ModelInContextNotFound
				do: [ :ex | ex return ] ].

	^ [ aContext modelFor: orderedCreators last ]
		on: ModelInContextNotFound
		do: [ :signal | 
			failuresByCreator isEmpty
				ifFalse: [ ModelCreationFailed signalObtainedFrom: failuresByCreator ] ]