Class {
	#name : #ISO8601DateParser,
	#superclass : #ISO8601Parser,
	#classVars : [
		'AcceptedFormats'
	],
	#category : #'Stardust-Parser'
}

{ #category : #parsing }
ISO8601DateParser class >> acceptedFormats [

	^ #('####-##-##' '+####-##-##' '-####-##-##' '########' '+########' '-########')
]

{ #category : #private }
ISO8601DateParser >> assertIsValidDate: aString withYear: year month: monthIndex day: dayOfMonth [

	AssertionCheckerBuilder new
		raising: DecodingFailed;
		checking: [ :asserter | 
			| daysInMonth |

			daysInMonth := Date daysInMonth: monthIndex forYear: year.
			asserter
				enforce: [ monthIndex between: 1 and: 12 ] because: ('Month ''<1p>'' should be between 1 and 12 in: <2p>' expandMacrosWith: monthIndex with: aString);
				enforce: [ dayOfMonth between: 1 and: daysInMonth ] because: ('Day of month ''<1p>'' should be between 1 and <2p> in: <3p>' expandMacrosWith: monthIndex with: daysInMonth with: aString) ];
		buildAndCheck
]

{ #category : #parsing }
ISO8601DateParser >> basicParse: stream [

	| sign year monthIndex dayOfMonth |

	sign := self parseSignFrom: stream.
	year := (stream next: 4) asNumber * sign.
	stream peek = $-
		ifTrue: [ stream next ].
	monthIndex := (stream next: 2) asNumber.
	stream peek = $-
		ifTrue: [ stream next ].
	dayOfMonth := stream upToEnd asNumber.
	self
		assertIsValidDate: stream contents
		withYear: year
		month: monthIndex
		day: dayOfMonth.
	^ Date year: year month: monthIndex day: dayOfMonth
]
