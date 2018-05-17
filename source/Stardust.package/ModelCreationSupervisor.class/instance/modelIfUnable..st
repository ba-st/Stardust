accessing
modelIfUnable: aBlock

	^ [ self model ]
		on: ModelCreationFailed
		do: [ :signal | signal return: aBlock value ]