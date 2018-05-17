initialization
initializeStartingAt: aCreator notifyingUserInteractionTo: aSupervisor handlingErrorsAccordingTo: anErrorDisplayStrategy

	| edges |

	self initialize.
	errorDisplayStrategy := anErrorDisplayStrategy.
	visitedCreators := Set new.
	edges := OrderedCollection new.
	self addEdgesFor: aCreator to: edges notifyingChangesTo: aSupervisor.
	creationGraph := Graph edges: edges nodes: visitedCreators.
	orderedCreators := (TopologicalSort for: creationGraph) value