accessing
changeModelTo: aModel in: aContext

	accessors
		with: (modelCreators first: accessors size)
		do: [ :accessor :modelCreator | aContext changeModelFor: modelCreator to: (aModel perform: accessor) ]