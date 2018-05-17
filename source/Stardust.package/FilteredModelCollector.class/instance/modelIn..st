accessing
modelIn: aContext

	| models |

	models := OrderedCollection new.
	optionalModelCreators do: [ :modelCreator | (aContext modelFor: modelCreator) withSelectionDo: [ :model | models add: model ] ].
	^ models