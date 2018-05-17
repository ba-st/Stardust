selection protocol
allowAnyOf: anElementCollection

	availableElements := anElementCollection.
	self
		choose: chosenElements
		matchedUsing: [ :chosenElement :availableElement | chosenElement = availableElement ]
		ifUnable: [ self clearSelection ]