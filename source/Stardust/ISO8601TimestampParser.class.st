Class {
	#name : #ISO8601TimestampParser,
	#superclass : #ISO8601Parser,
	#classVars : [
		'AcceptedFormats'
	],
	#category : #'Stardust-Parser'
}

{ #category : #parsing }
ISO8601TimestampParser class >> acceptedFormats [

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
]

{ #category : #'private-parsing' }
ISO8601TimestampParser >> assertIsValidTime: aString withHour: hours minute: minutes [

	AssertionCheckerBuilder new
		raising: ParsingFailed;
		checking: [ :asserter | 
			asserter
				enforce: [ hours between: -3 and: 23 ]
					because: ('Hours ''<1p>'' should be between -23 and 23 in: <2p>' expandMacrosWith: hours with: aString);
				enforce: [ minutes between: 0 and: 59 ]
					because: ('Minutes ''<1p>'' should be between 0 and 59 in: <2p>' expandMacrosWith: minutes with: aString) ];
		buildAndCheck
]

{ #category : #'private-parsing' }
ISO8601TimestampParser >> basicParse: stream [

	| offset date time |

	date := ISO8601DateParser new parse: (stream upTo: $T).
	time := ISO8601TimeParser new parse: (self extractTimeFrom: stream).
	offset := self parseOffsetFrom: stream upToEnd.

	^ DateAndTime
		year: date year
		month: date monthIndex
		day: date dayOfMonth
		hour: time hour
		minute: time minute
		second: time second
		nanoSecond: time nanoSecond
		offset: offset
]

{ #category : #'private-parsing' }
ISO8601TimestampParser >> extractTimeFrom: stream [

	| timeAndOffset timeLength |

	timeAndOffset := stream contents copyFrom: stream position to: stream size.
	timeLength := ('+-Z' max: [ :c | timeAndOffset indexOf: c ]) - 1.
	^ stream next: timeLength - 1
]

{ #category : #'private-parsing' }
ISO8601TimestampParser >> parseDurationFrom: stream [

	| hour minute sign |

	sign := self parseSignFrom: stream.
	hour := sign * (stream next: 2) asNumber.
	minute := stream atEnd
		ifTrue: [ 0 ]
		ifFalse: [ stream peek = $:
				ifTrue: [ stream next ].
			(stream next: 2) asNumber ].
	self assertIsValidTime: stream contents withHour: hour minute: minute.
	^ Duration
		days: 0
		hours: hour
		minutes: minute
		seconds: 0
]

{ #category : #'private-parsing' }
ISO8601TimestampParser >> parseOffsetFrom: gmtOffsetString [

	^ gmtOffsetString = 'Z'
		ifTrue: [ Duration zero ]
		ifFalse: [ self parseDurationFrom: gmtOffsetString readStream ]
]
