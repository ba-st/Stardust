Class {
	#name : #SupervisorStrategy,
	#superclass : #Object,
	#instVars : [
		'handler'
	],
	#category : #Stardust
}

{ #category : #'instance creation' }
SupervisorStrategy class >> displayingMultipleErrors [

	| handler |

	handler := [ :signal :creator :failuresByCreator | 
	failuresByCreator at: creator put: ('<1s>: <2s>' expandMacrosWith: creator name with: signal messageText).
	signal return ].

	^ self handlingErrorsWith: handler
]

{ #category : #'instance creation' }
SupervisorStrategy class >> displayingSingleError [

	| handler |

	handler := [ :signal :creator :failuresByCreator | ModelCreationFailed signalOf: creator dueTo: signal ].

	^ self handlingErrorsWith: handler
]

{ #category : #'private-instance creation' }
SupervisorStrategy class >> handlingErrorsWith: handler [

	^ self new initializeHandlingErrorsWith: handler
]

{ #category : #handling }
SupervisorStrategy >> handle: signal originatedIn: creator storingFailuresOn: failuresByCreator [

	^ (MultiplexedInstanceCreationFailed handles: signal)
		ifTrue: [ signal userAwareDescriptionsByCreators
				keysAndValuesDo: [ :innerCreator :errorDescription | 
					handler
						value:
							(MultiplexedInstanceCreationSignalFossil
								with: (errorDescription allButFirst: innerCreator name size + 2))
						value: innerCreator
						value: failuresByCreator ] ]
		ifFalse: [ handler value: signal value: creator value: failuresByCreator ]
]

{ #category : #initialization }
SupervisorStrategy >> initializeHandlingErrorsWith: aHandler [

	handler := aHandler
]
