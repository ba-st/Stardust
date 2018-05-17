accessing
changeModelTo: aModelCollection in: aContext

	modelCreators with: aModelCollection do: [ :modelCreator :model | aContext changeModelFor: modelCreator to: model ]