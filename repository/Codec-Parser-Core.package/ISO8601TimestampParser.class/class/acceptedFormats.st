parsing
acceptedFormats

	"ISO-8601 allows combinations of: <date>T<time><offset> where:
		<date> = YYYY-MM-DD or +YYYY-MM-DD or -YYYY-MM-DD
		<time> = HH:MM:SS.sss or HH:MM:SS or HH:MM
		<offset> = Z or +HH or +HHSS or +HH:SS or -HH or -HHSS or -HH:SS"

	AcceptedFormats
		ifNil: [ | dateFormats timeFormats offsetFormats formats |

			dateFormats := #('####-##-##' '+####-##-##' '-####-##-##').
			timeFormats := #('##:##:##*' '##:##').
			offsetFormats := #('Z' '+##' '+####' '+##:##' '-##' '-####' '-##:##').
			formats := OrderedCollection new.
			dateFormats
				do: [ :dateFormat | timeFormats do: [ :timeFormat | offsetFormats collect: [ :offsetFormat | '<1s>T<2s><3s>' expandMacrosWith: dateFormat with: timeFormat with: offsetFormat ] into: formats ] ].
			AcceptedFormats := formats asArray ].
	^ AcceptedFormats