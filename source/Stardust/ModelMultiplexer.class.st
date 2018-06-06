Class {
	#name : #ModelMultiplexer,
	#superclass : #ModelCreator,
	#instVars : [
		'supervisorsByName',
		'selectionModelCreator'
	],
	#category : #'Stardust-ModelCreation'
}

{ #category : #'instance creation' }
ModelMultiplexer class >> multiplexing: aModelCreatorCollection selectingFrom: aSingleSelectionView [

	^ self new initializeMultiplexing: aModelCreatorCollection selectingFrom: aSingleSelectionView
]

{ #category : #testing }
ModelMultiplexer >> canCreate: aModel [

	^ self
		supervisorFor: aModel
		ifFound: [ :supervisor | true ]
		ifNone: [ false ]
]

{ #category : #accessing }
ModelMultiplexer >> changeModelTo: aModel in: aContext [

	self
		supervisorFor: aModel
		ifFound: [ :supervisor | 
			self changeSelectionModelIn: aContext using: supervisor.
			supervisor changeModelTo: aModel ]
		ifNone: [ ObjectNotFound signal: 'More than one vaid model was found' ]
]

{ #category : #private }
ModelMultiplexer >> changeSelectionModelIn: aContext using: aCurrentSupervisor [

	| supervisorChanged |

	supervisorChanged := [ (self supervisorToUseIn: aContext) ~= aCurrentSupervisor ]
		on: ModelInContextNotFound
		do: [ :aSignal | aSignal return: true ].
		
	supervisorChanged
		ifTrue: [ selectionModelCreator
				changeModelTo: (supervisorsByName keyAtValue: aCurrentSupervisor)
				in: aContext ]
]

{ #category : #enumerating }
ModelMultiplexer >> dependenciesDo: aBlock [

	aBlock value: selectionModelCreator
]

{ #category : #initialization }
ModelMultiplexer >> initializeMultiplexing: aModelCreatorCollection selectingFrom: aSingleModelPicker [

	selectionModelCreator := aSingleModelPicker.
	selectionModelCreator
		allowAnyOf: (aModelCreatorCollection collect: [ :modelCreator | modelCreator name ]).

	supervisorsByName := Dictionary new.
	aModelCreatorCollection
		do: [ :modelCreator | 
			| supervisor |

			supervisor := ModelCreationSupervisor
				supervising: modelCreator
				showingErrorsAccordingTo: SupervisorStrategy displayingMultipleErrors.
			supervisorsByName at: modelCreator name put: supervisor ]
]

{ #category : #accessing }
ModelMultiplexer >> modelIn: aContext [

	| currentSupervisor |

	currentSupervisor := self supervisorToUseIn: aContext.
	^ [ currentSupervisor model ]
		on: ModelCreationFailed
		do: [ :aSignal | MultiplexedInstanceCreationFailed signalObtainedFrom: aSignal userAwareDescriptionsByCreators ]
]

{ #category : #accessing }
ModelMultiplexer >> name [

	^ selectionModelCreator name
]

{ #category : #notifying }
ModelMultiplexer >> notifyChangesTo: aSupervisor [

	
]

{ #category : #private }
ModelMultiplexer >> supervisorFor: aModel ifFound: aMonadycBlock ifNone: aBlock [

	^ supervisorsByName
		detect: [ :supervisor | supervisor canCreate: aModel ]
		ifFound: aMonadycBlock
		ifNone: aBlock
]

{ #category : #private }
ModelMultiplexer >> supervisorToUseIn: aContext [

	| currentSupervisor currentModel |

	currentModel := aContext modelFor: selectionModelCreator.
	currentSupervisor := supervisorsByName at: currentModel.
	^ currentSupervisor
]
