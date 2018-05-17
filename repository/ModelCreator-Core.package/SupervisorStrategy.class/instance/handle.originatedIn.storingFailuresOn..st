handling
handle: signal originatedIn: creator storingFailuresOn: failuresByCreator

	^ (MultiplexedInstanceCreationFailed handles: signal)
		ifTrue: [ signal userAwareDescriptionsByCreators
				keysAndValuesDo: [ :innerCreator :errorDescription | 
					handler
						value: (MultiplexedInstanceCreationSignalFossil with: (errorDescription allButFirst: innerCreator name size + 2))
						value: innerCreator
						value: failuresByCreator ] ]
		ifFalse: [ handler value: signal value: creator value: failuresByCreator ]