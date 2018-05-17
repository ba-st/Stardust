initialization
initializeMultiplexing: aModelCreatorCollection selectingFrom: aSingleModelPicker

	selectionModelCreator := aSingleModelPicker.
	selectionModelCreator allowAnyOf: (aModelCreatorCollection collect: [ :modelCreator | modelCreator name ]).

	supervisorsByName := Dictionary new.
	aModelCreatorCollection
		do: [ :modelCreator | 
			| supervisor |

			supervisor := ModelCreationSupervisor supervising: modelCreator showingErrorsAccordingTo: SupervisorStrategy displayingMultipleErrors.
			supervisorsByName at: modelCreator name put: supervisor ]