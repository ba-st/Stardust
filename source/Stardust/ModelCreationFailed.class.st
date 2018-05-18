Class {
	#name : #ModelCreationFailed,
	#superclass : #Error,
	#category : 'Stardust-ModelCreator'
}

{ #category : #'instance creation' }
ModelCreationFailed class >> signalObtainedFrom: failuresByCreatorDictionary [

	^ self new
		tag: failuresByCreatorDictionary;
		signal: ((CollectionFormatter separatingWith: Character cr asString) format: failuresByCreatorDictionary values asSortedCollection)
]

{ #category : #'instance creation' }
ModelCreationFailed class >> signalOf: aCreator dueTo: aSignal [

	| failuresByCreatorDictionary |

	failuresByCreatorDictionary := Dictionary new
		at: aCreator put: ('<1s>: <2s>' expandMacrosWith: aCreator name with: aSignal userAwareDescription);
		yourself.

	self signalObtainedFrom: failuresByCreatorDictionary
]

{ #category : #accessing }
ModelCreationFailed >> userAwareDescriptionsByCreators [

	^ self tag
]
