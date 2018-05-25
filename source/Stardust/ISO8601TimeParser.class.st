Class {
	#name : #ISO8601TimeParser,
	#superclass : #ISO8601Parser,
	#category : #'Stardust-Parser'
}

{ #category : #parsing }
ISO8601TimeParser class >> acceptedFormats [

	"ISO-8601 allows HH:MM:SS.sss or HH:MM:SS or HH:MM or HHMMSS.sss or HHMMSS or HHMM"

	^ #('##:##:##.*' '##:##:##' '##:##' '######.*' '######' '####')
]

{ #category : #private }
ISO8601TimeParser >> assertIsValidTime: aString withHour: hours minute: minutes second: seconds nanoSecond: nanoSeconds [

	AssertionCheckerBuilder new
		raising: ParsingFailed;
		checking: [ :asserter | 
			asserter
				enforce: [ hours between: 0 and: 23 ] because: ('Hours ''<1p>'' should be between 0 and 23 in: <2p>' expandMacrosWith: hours with: aString);
				enforce: [ minutes between: 0 and: 59 ] because: ('Minutes ''<1p>'' should be between 0 and 59 in: <2p>' expandMacrosWith: minutes with: aString);
				enforce: [ seconds between: 0 and: 59 ] because: ('Seconds ''<1p>'' should be between 0 and 59 in: <2p>' expandMacrosWith: minutes with: aString);
				enforce: [ nanoSeconds between: 0 and: 999999999 ] because: ('Nano ''<1p>'' should be between 0 and 999999999 in: <2p>' expandMacrosWith: minutes with: aString) ];
		buildAndCheck
]

{ #category : #private }
ISO8601TimeParser >> basicParse: stream [

	| hour minute second nanoSecond |

	hour := (stream next: 2) asNumber.
	stream peek = $:
		ifTrue: [ stream next ].
	minute := (stream next: 2) asNumber.
	stream peek = $:
		ifTrue: [ stream next ].
	stream atEnd
		ifTrue: [ second := nanoSecond := 0 ]
		ifFalse: [ second := (stream next: 2) asNumber.
			nanoSecond := stream peek = $.
				ifTrue: [ stream next.
					(stream upToEnd padRightTo: 9 with: $0) asNumber ]
				ifFalse: [ 0 ] ].
	self
		assertIsValidTime: stream contents
		withHour: hour
		minute: minute
		second: second
		nanoSecond: nanoSecond.
	^ Time
		hour: hour
		minute: minute
		second: second
		nanoSecond: nanoSecond
]
