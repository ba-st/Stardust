"
I'm responsible of given a top level creator, figure it out the right order to evaluate the child creators so the top level model can be created. 
I can respond for any creator in the given graph, the other ones affected by changes in it.

I'm a private class not intended to be used outside the library.
"
Class {
	#name : #ModelCreationSequence,
	#superclass : #Object,
	#instVars : [
		'creationGraph',
		'orderedCreators',
		'errorDisplayStrategy'
	],
	#category : #Stardust
}

{ #category : #'instance creation' }
ModelCreationSequence class >> startingAt: aTopLevelCreator notifyingChangesTo: aSupervisor handlingErrorsAccordingTo: anErrorDisplayStrategy [

	^ self new initializeStartingAt: aTopLevelCreator notifyingUserInteractionTo: aSupervisor handlingErrorsAccordingTo: anErrorDisplayStrategy
]

{ #category : #testing }
ModelCreationSequence >> canCreate: aModel [

	^ self topLevelCreator canCreate: aModel
]

{ #category : #disassembling }
ModelCreationSequence >> changeModelTo: aModel in: aContext [

	aContext changeModelFor: self topLevelCreator to: aModel
]

{ #category : #private }
ModelCreationSequence >> configure: graphBuilder byRelatingRecursivelyDependenciesOf: aCreator keepingTrackOfProgressOn: aRecursionSet whileNotifyingChangesTo: aSupervisor [

	(aRecursionSet includes: aCreator)
		ifTrue: [ ^ self ].

	aRecursionSet add: aCreator.
	aCreator notifyChangesTo: aSupervisor.
	aCreator
		dependenciesDo: [ :dependency | 
			graphBuilder connect: dependency to: aCreator.
			self
				configure: graphBuilder
				byRelatingRecursivelyDependenciesOf: dependency
				keepingTrackOfProgressOn: aRecursionSet
				whileNotifyingChangesTo: aSupervisor ]
]

{ #category : #private }
ModelCreationSequence >> creatorsAffectedByChangeIn: aCreator [

	^ creationGraph verticesReachableFrom: aCreator
]

{ #category : #initialization }
ModelCreationSequence >> initializeStartingAt: aTopLevelCreator notifyingUserInteractionTo: aSupervisor handlingErrorsAccordingTo: anErrorDisplayStrategy [

	| graphBuilder |

	errorDisplayStrategy := anErrorDisplayStrategy.
	graphBuilder := DirectedGraphBuilder new.
	graphBuilder addVertex: aTopLevelCreator.
	self
		configure: graphBuilder
		byRelatingRecursivelyDependenciesOf: aTopLevelCreator
		keepingTrackOfProgressOn: Set new
		whileNotifyingChangesTo: aSupervisor.
	creationGraph := graphBuilder build.
	orderedCreators := creationGraph topologicalSort
]

{ #category : #invalidating }
ModelCreationSequence >> invalidateModelFor: aCreator in: modelCreationContext [

	modelCreationContext invalidateModelFor: aCreator.
	(self creatorsAffectedByChangeIn: aCreator) do: [ :dependent | modelCreationContext invalidateModelFor: dependent ]
]

{ #category : #assembling }
ModelCreationSequence >> modelIn: aContext [

	| failuresByCreator |

	failuresByCreator := Dictionary new.
	orderedCreators
		do: [ :creator | 
			[ [ aContext modelInSequenceFor: creator ]
				on: InstanceCreationFailed
				do: [ :signal | errorDisplayStrategy handle: signal originatedIn: creator storingFailuresOn: failuresByCreator ] ]
				on: ModelInContextNotFound
				do: [ :ex | ex return ] ].

	^ [ aContext modelFor: self topLevelCreator ]
		on: ModelInContextNotFound
		do: [ :signal | failuresByCreator ifNotEmpty: [ ModelCreationFailed signalObtainedFrom: failuresByCreator ] ]
]

{ #category : #private }
ModelCreationSequence >> topLevelCreator [

	^ orderedCreators last
]
