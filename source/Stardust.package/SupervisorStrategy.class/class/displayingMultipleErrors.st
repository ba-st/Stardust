instance creation
displayingMultipleErrors

	| handler |

	handler := [ :signal :creator :failuresByCreator | 
	failuresByCreator at: creator put: ('<1s>: <2s>' expandMacrosWith: creator name with: signal userAwareDescription).
	signal return ].

	^ self handlingErrorsWith: handler