signalling
signalObtainedFrom: failuresByCreatorDictionary

	^ self new
		tag: failuresByCreatorDictionary;
		signal: ((CollectionFormatter separatingWith: Character cr asString) format: failuresByCreatorDictionary values asSortedCollection)