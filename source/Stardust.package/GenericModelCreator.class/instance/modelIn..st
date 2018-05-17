accessing
modelIn: aContext

	| models |

	models := modelCreators collect: [ :modelCreator | aContext modelFor: modelCreator ].
	^ self modelClass perform: instanceCreationSelector withArguments: models