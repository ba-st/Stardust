testing
canCreate: aModel

	^ (self modelClass isClass not or: [ aModel isA: self modelClass ])
		and: [ | allowedByAccessors |

			allowedByAccessors := true.
			accessors
				with: (modelCreators first: accessors size)
				do: [ :accessor :modelCreator | allowedByAccessors := allowedByAccessors and: [ modelCreator canCreate: (aModel perform: accessor) ] ].
			allowedByAccessors ]