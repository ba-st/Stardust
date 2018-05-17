private
supervisorToUseIn: aContext

	| currentSupervisor currentModel |

	currentModel := aContext modelFor: selectionModelCreator.
	currentSupervisor := supervisorsByName at: currentModel.
	^ currentSupervisor