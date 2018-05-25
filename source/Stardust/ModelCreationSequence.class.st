Class {
	#name : #ModelCreationSequence,
	#superclass : #Object,
	#instVars : [
		'visitedCreators',
		'creationGraph',
		'orderedCreators',
		'errorDisplayStrategy'
	],
	#category : #'Stardust-ModelCreator'
}

{ #category : #'instance creation' }
ModelCreationSequence class >> startingAt: aCreator notifyingChangesTo: aSupervisor handlingErrorsAccordingTo: anErrorDisplayStrategy [

	^ self new initializeStartingAt: aCreator notifyingUserInteractionTo: aSupervisor handlingErrorsAccordingTo: anErrorDisplayStrategy
]

{ #category : #private }
ModelCreationSequence >> addEdgesFor: aCreator to: edges notifyingChangesTo: aSupervisor [

	(visitedCreators includes: aCreator)
		ifTrue: [ ^ self ].
	visitedCreators add: aCreator.
	aCreator notifyChangesTo: aSupervisor.
	aCreator
		dependenciesDo: [ :dependency | 
			edges add: (Edge from: dependency to: aCreator).
			self addEdgesFor: dependency to: edges notifyingChangesTo: aSupervisor ]
]

{ #category : #testing }
ModelCreationSequence >> canCreate: aModel [

	^ orderedCreators last canCreate: aModel
]

{ #category : #accessing }
ModelCreationSequence >> changeModelTo: aModel in: aContext [

	aContext changeModelFor: orderedCreators last to: aModel
]

{ #category : #accessing }
ModelCreationSequence >> creatorsAffectedByChangeIn: aCreator [

	| affectedCreators |

	affectedCreators := Set with: aCreator.
	(creationGraph edgesStartingOn: aCreator) do: [ :edge | affectedCreators addAll: (self creatorsAffectedByChangeIn: edge target) ].
	^ affectedCreators
]

{ #category : #initialization }
ModelCreationSequence >> initializeStartingAt: aCreator notifyingUserInteractionTo: aSupervisor handlingErrorsAccordingTo: anErrorDisplayStrategy [

	| edges |

	self initialize.
	errorDisplayStrategy := anErrorDisplayStrategy.
	visitedCreators := Set new.
	edges := OrderedCollection new.
	self addEdgesFor: aCreator to: edges notifyingChangesTo: aSupervisor.
	creationGraph := Graph edges: edges nodes: visitedCreators.
	orderedCreators := (TopologicalSort for: creationGraph) value
]

{ #category : #accessing }
ModelCreationSequence >> modelIn: aContext [

	| failuresByCreator |

	failuresByCreator := Dictionary new.
	orderedCreators
		do: [ :creator | 
			[ [ aContext modelInSequenceFor: creator ]
				on: ModelCreationFailed
				do: [ :signal | 
					errorDisplayStrategy
						handle: signal
						originatedIn: creator
						storingFailuresOn: failuresByCreator ] ]
				on: ModelInContextNotFound
				do: [ :ex | ex return ] ].

	^ [ aContext modelFor: orderedCreators last ]
		on: ModelInContextNotFound
		do: [ :signal | 
			failuresByCreator isEmpty
				ifFalse: [ ModelCreationFailed signalObtainedFrom: failuresByCreator ] ]
]
