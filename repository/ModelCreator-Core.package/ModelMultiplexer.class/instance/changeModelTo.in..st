accessing
changeModelTo: aModel in: aContext

	| validSupervisors currentSupervisor |

	validSupervisors := self validSupervisorsFor: aModel.
	validSupervisors size = 1
		ifFalse: [ ProgrammingError signal: 'More than one vaid model was found' ].
	currentSupervisor := validSupervisors anyOne.
	self changeSelectionModelIn: aContext using: currentSupervisor.
	currentSupervisor changeModelTo: aModel