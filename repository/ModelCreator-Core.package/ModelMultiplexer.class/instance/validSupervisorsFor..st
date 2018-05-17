private
validSupervisorsFor: aModel

	^ supervisorsByName select: [ :supervisor | supervisor canCreate: aModel ]