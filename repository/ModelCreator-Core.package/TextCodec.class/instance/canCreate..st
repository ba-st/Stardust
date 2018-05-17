testing
canCreate: anObject

	^ [ (parser parse: (formatter format: anObject)) = anObject ]
		on: InstanceCreationFailed , ParsingFailed
		do: [ :aSignal | aSignal return: false ]