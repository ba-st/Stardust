accessing
changeModelTo: aModelCollection in: aContext

	optionalModelCreators do: [ :modelCreator | aContext changeModelFor: modelCreator to: UINullSelection new ].

	aModelCollection
		do: [ :aModel | 
			| selection |

			selection := UISelection is: aModel.
			optionalModelCreators
				detect: [ :modelCreator | modelCreator canCreate: selection ]
				ifFound: [ :modelCreator | aContext changeModelFor: modelCreator to: selection ] ]