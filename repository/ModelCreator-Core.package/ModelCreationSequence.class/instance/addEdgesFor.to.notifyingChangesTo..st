private
addEdgesFor: aCreator to: edges notifyingChangesTo: aSupervisor

	(visitedCreators includes: aCreator)
		ifTrue: [ ^ self ].
	visitedCreators add: aCreator.
	aCreator notifyChangesTo: aSupervisor.
	aCreator
		dependenciesDo: [ :dependency | 
			edges add: (Edge from: dependency to: aCreator).
			self addEdgesFor: dependency to: edges notifyingChangesTo: aSupervisor ]