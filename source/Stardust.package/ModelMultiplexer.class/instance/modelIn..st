accessing
modelIn: aContext

	| currentSupervisor |

	currentSupervisor := self supervisorToUseIn: aContext.
	^ [ currentSupervisor model ]
		on: ModelCreationFailed
		do: [ :aSignal | MultiplexedInstanceCreationFailed signalObtainedFrom: aSignal userAwareDescriptionsByCreators ]