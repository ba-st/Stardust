Class {
	#name : #ModelCreationSequence,
	#superclass : #Object,
	#instVars : [
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

	^ Set new
		add: aCreator;
		addAll: (creationGraph verticesReachableFrom: aCreator);
		yourself
]

{ #category : #initialization }
ModelCreationSequence >> initializeStartingAt: aCreator notifyingUserInteractionTo: aSupervisor handlingErrorsAccordingTo: anErrorDisplayStrategy [

	| graphBuilder |

	self initialize.
	errorDisplayStrategy := anErrorDisplayStrategy.
	graphBuilder := DirectedGraphBuilder new.
	graphBuilder addVertex: aCreator.
	self
		relateDependenciesOf: aCreator
		configuring: graphBuilder
		notifyingChangesTo: aSupervisor
		alreadySeen: Set new.
	creationGraph := graphBuilder build.
	orderedCreators := creationGraph topologicalSort
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

{ #category : #private }
ModelCreationSequence >> relateDependenciesOf: aCreator configuring: graphBuilder notifyingChangesTo: aSupervisor alreadySeen: aRecursionSet [

	(aRecursionSet includes: aCreator)
		ifTrue: [ ^ self ].

	aRecursionSet add: aCreator.
	aCreator notifyChangesTo: aSupervisor.
	aCreator
		dependenciesDo: [ :dependency | 
			graphBuilder connect: dependency to: aCreator.
			self
				relateDependenciesOf: dependency
				configuring: graphBuilder
				notifyingChangesTo: aSupervisor
				alreadySeen: aRecursionSet ]
]
