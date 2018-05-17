accessing
allowAnyOf: anElementCollection

	availableElements := anElementCollection.

	self
		chooseAnySatisfying: [ :element | 
			chosenElement
				withContentDo: [ :theElement | theElement = element ]
				ifUnused: [ false ] ]
		ifNone: [ self invalidateSelection ]