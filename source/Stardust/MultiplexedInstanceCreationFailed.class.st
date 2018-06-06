Class {
	#name : #MultiplexedInstanceCreationFailed,
	#superclass : #InstanceCreationFailed,
	#category : #'Stardust-ModelCreation'
}

{ #category : #signalling }
MultiplexedInstanceCreationFailed class >> signalObtainedFrom: failuresByCreatorDictionary [

	^ self new
		tag: failuresByCreatorDictionary;
		signal: ((CollectionFormatter separatingWith: Character cr asString) format: failuresByCreatorDictionary values asSortedCollection)
]

{ #category : #accessing }
MultiplexedInstanceCreationFailed >> userAwareDescriptionsByCreators [

	^ self tag
]
