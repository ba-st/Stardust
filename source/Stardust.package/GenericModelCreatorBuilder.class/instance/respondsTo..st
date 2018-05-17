reflective operations
respondsTo: aSelector

	^ (self class canUnderstand: aSelector)
		or: [ [ modelClass respondsTo: aSelector ]
				on: InstanceCreationFailed
				do: [ :aSignal | aSignal return: false ] ]