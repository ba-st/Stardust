selection protocol
allowAnyOf: anElementCollection

	availableElements := anElementCollection.
	chosenElement
		withContentDo: [ :selection | self chooseAnySatisfying: [ :element | selection = element ] ifNone: [ self invalidateSelection ] ]
		ifUnused: [ self invalidateSelection ]