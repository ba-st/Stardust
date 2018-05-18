Class {
	#name : #ModelMultiplexer,
	#superclass : #ModelCreator,
	#instVars : [
		'supervisorsByName',
		'selectionModelCreator'
	],
	#category : #'Stardust-ModelCreator'
}

{ #category : #'instance creation' }
ModelMultiplexer class >> multiplexing: aModelCreatorCollection selectingFrom: aSingleSelectionView [

	^ self new initializeMultiplexing: aModelCreatorCollection selectingFrom: aSingleSelectionView
]

{ #category : #testing }
ModelMultiplexer >> canCreate: aModel [

	^ (self validSupervisorsFor: aModel) notEmpty
]

{ #category : #accessing }
ModelMultiplexer >> changeModelTo: aModel in: aContext [

	| validSupervisors currentSupervisor |

	validSupervisors := self validSupervisorsFor: aModel.
	validSupervisors size = 1
		ifFalse: [ ProgrammingError signal: 'More than one vaid model was found' ].
	currentSupervisor := validSupervisors anyOne.
	self changeSelectionModelIn: aContext using: currentSupervisor.
	currentSupervisor changeModelTo: aModel
]

{ #category : #private }
ModelMultiplexer >> changeSelectionModelIn: aContext using: aCurrentSupervisor [

	| supervisorChanged |

	supervisorChanged := [ (self supervisorToUseIn: aContext) ~= aCurrentSupervisor ]
		on: ModelInContextNotFound
		do: [ :aSignal | aSignal return: true ].
	supervisorChanged
		ifTrue: [ selectionModelCreator changeModelTo: (supervisorsByName keyAtValue: aCurrentSupervisor) in: aContext ]
]

{ #category : #enumerating }
ModelMultiplexer >> dependenciesDo: aBlock [

	aBlock value: selectionModelCreator
]

{ #category : #initialization }
ModelMultiplexer >> initializeMultiplexing: aModelCreatorCollection selectingFrom: aSingleModelPicker [

	selectionModelCreator := aSingleModelPicker.
	selectionModelCreator allowAnyOf: (aModelCreatorCollection collect: [ :modelCreator | modelCreator name ]).

	supervisorsByName := Dictionary new.
	aModelCreatorCollection
		do: [ :modelCreator | 
			| supervisor |

			supervisor := ModelCreationSupervisor supervising: modelCreator showingErrorsAccordingTo: SupervisorStrategy displayingMultipleErrors.
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
ModelMultiplexer >> supervisorToUseIn: aContext [

	| currentSupervisor currentModel |

	currentModel := aContext modelFor: selectionModelCreator.
	currentSupervisor := supervisorsByName at: currentModel.
	^ currentSupervisor
]

{ #category : #private }
ModelMultiplexer >> validSupervisorsFor: aModel [

	^ supervisorsByName select: [ :supervisor | supervisor canCreate: aModel ]
]
