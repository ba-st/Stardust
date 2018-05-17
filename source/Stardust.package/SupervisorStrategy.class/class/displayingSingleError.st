instance creation
displayingSingleError

	| handler |

	handler := [ :signal :creator :failuresByCreator | ModelCreationFailed signalOf: creator dueTo: signal ].

	^ self handlingErrorsWith: handler