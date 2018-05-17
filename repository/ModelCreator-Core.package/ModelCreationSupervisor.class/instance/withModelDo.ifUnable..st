accessing
withModelDo: aMonadycBlock ifUnable: aModelCreationFailedBlock

	| model modelCreated |

	modelCreated := [ model := self model.
	true ]
		on: ModelCreationFailed
		do: [ :signal | signal return: false ].
	^ modelCreated
		ifTrue: [ aMonadycBlock value: model ]
		ifFalse: aModelCreationFailedBlock