"
I'm the error that will be signaled when some supervisor is unable to create the required model. 
I can be queried for the error messages generated by the creators that failed during the process.
"
Class {
	#name : #ModelCreationFailed,
	#superclass : #Error,
	#category : #Stardust
}

{ #category : #'instance creation' }
ModelCreationFailed class >> signalObtainedFrom: failuresByCreatorDictionary [

	^ self new
		tag: failuresByCreatorDictionary;
		signal: ((CollectionFormatter separatingWith: Character cr) format: failuresByCreatorDictionary values sorted)
]

{ #category : #'instance creation' }
ModelCreationFailed class >> signalOf: aCreator dueTo: aSignal [

	| failuresByCreatorDictionary |

	failuresByCreatorDictionary := Dictionary new
		at: aCreator put: ('<1s>: <2s>' expandMacrosWith: aCreator name with: aSignal messageText);
		yourself.

	self signalObtainedFrom: failuresByCreatorDictionary
]

{ #category : #accessing }
ModelCreationFailed >> userAwareDescriptionsByCreators [

	^ self tag
]
