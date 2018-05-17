private
changeSelectionModelIn: aContext using: aCurrentSupervisor

	| supervisorChanged |

	supervisorChanged := [ (self supervisorToUseIn: aContext) ~= aCurrentSupervisor ]
		on: ModelInContextNotFound
		do: [ :aSignal | aSignal return: true ].
	supervisorChanged
		ifTrue: [ selectionModelCreator changeModelTo: (supervisorsByName keyAtValue: aCurrentSupervisor) in: aContext ]