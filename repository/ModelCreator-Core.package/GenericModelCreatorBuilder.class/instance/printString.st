printing
printString

	"Implementado para evitar que lo agarre el DNU. -mtabacman"

	^ String streamContents: [ :stream | self printOn: stream ]