Class {
	#name : #ScaledDecimalParser,
	#superclass : #Object,
	#instVars : [
		'thousandsSeparator',
		'decimalSeparator'
	],
	#category : #'Stardust-Parser'
}

{ #category : #'instance creation' }
ScaledDecimalParser class >> decimalsSeparatedBy: aDecimalSeparator [

	^ self decimalsSeparatedBy: aDecimalSeparator thousandsSeparatedAcordingTo: Optional unused
]

{ #category : #'private-instance creation' }
ScaledDecimalParser class >> decimalsSeparatedBy: aDecimalSeparator thousandsSeparatedAcordingTo: aThousandsOptional [

	^ super new initializeWithDecimalsSeparatedBy: aDecimalSeparator thousandsSeparatedAcordingTo: aThousandsOptional
]

{ #category : #'instance creation' }
ScaledDecimalParser class >> decimalsSeparatedBy: aDecimalSeparator thousandsSeparatedBy: aThousandsSeparator [

	^ self decimalsSeparatedBy: aDecimalSeparator thousandsSeparatedAcordingTo: (Optional containing: aThousandsSeparator)
]

{ #category : #'instance creation' }
ScaledDecimalParser class >> new [

	^ self decimalsSeparatedBy: $.
]

{ #category : #initialization }
ScaledDecimalParser >> assertWellFormed: aString [

	AssertionCheckerBuilder new
		raising: (ParsingFailedFactory parsing: aString);
		checking: [ :mayBeEmpty | 
			mayBeEmpty
				refuse: [ aString isEmpty ]
				because: 'Empty string is not an number'
				onSuccess: [ :asserter | 
					| substrings nonSignPart |

					self checkSignOf: aString using: asserter.
					nonSignPart := aString first isDigit
						ifFalse: [ aString allButFirst ]
						ifTrue: [ aString ].
					substrings := nonSignPart substrings: decimalSeparator asString.
					asserter
						enforce: [ (substrings size between: 1 and: 2) and: [ (aString count: [ :character | character = decimalSeparator ]) <= 1 ] ]
						because: ('A number can only have one decimal separator (<1s>) and must have an integer part' expandMacrosWith: decimalSeparator asString)
						onSuccess: [ :scaledDecimalAsserter | 
							substrings size = 2
								ifTrue: [ self checkDecimalPart: (substrings at: 2) using: scaledDecimalAsserter ]
								ifFalse:
									[ scaledDecimalAsserter refuse: [ aString last = decimalSeparator ] because: ('A number can not end with a decimal separator (<1s>)' expandMacrosWith: decimalSeparator asString) ].
							self checkIntegerPart: substrings first using: scaledDecimalAsserter ] ] ];
		buildAndCheck
]

{ #category : #initialization }
ScaledDecimalParser >> checkDecimalPart: decimalPart using: scaledDecimalAsserter [

	scaledDecimalAsserter
		enforce: [ decimalPart allSatisfy: #isDigit ]
		because: 'A number has decimal / fractional part with digits'
]

{ #category : #initialization }
ScaledDecimalParser >> checkIntegerPart: integerPart using: mayBeEmpty [

	^ mayBeEmpty
		refuse: [ integerPart isEmpty ]
		because: 'Integer part can not be empty'
		onSuccess: [ :asserter | 
			thousandsSeparator
				withContentDo: [ :separator | 
					asserter
						enforce: [ self is: integerPart separatedByThousandsWith: separator ]
						because:
							('A number has an integer part with digits separated every third decimal place with: <1p> optionally prepended by + or -'
								expandMacrosWith: separator) ]
				ifUnused: [ asserter
						enforce: [ integerPart allSatisfy: #isDigit ]
						because: 'A number has an integer part with digits optionally prepended by + or -' ] ]
]

{ #category : #initialization }
ScaledDecimalParser >> checkSignOf: aString using: asserter [

	asserter
		enforce:
			[ aString first isDigit | (aString first = $+) | (aString first = $-) ]
		because:
			('First character of an number is either a digit, + or -, not <1s>'
				expandMacrosWith: aString first asString)
]

{ #category : #initialization }
ScaledDecimalParser >> initializeWithDecimalsSeparatedBy: aDecimalSeparator thousandsSeparatedAcordingTo: aThousandsOptional [

	decimalSeparator := aDecimalSeparator.
	thousandsSeparator := aThousandsOptional
]

{ #category : #initialization }
ScaledDecimalParser >> is: aNumberString separatedByThousandsWith: separator [

	"Backwards (in ascending significance), every 4th must be the separator, all the others must be digits"

	| reversedNumber |

	reversedNumber := aNumberString reversed.
	reversedNumber
		doWithIndex: [ :character :index | 
			index \\ 4 = 0
				ifTrue: [ character = separator
						ifFalse: [ ^ false ] ]
				ifFalse: [ character isDigit
						ifFalse: [ ^ false ] ] ].
	^ true
]

{ #category : #initialization }
ScaledDecimalParser >> parse: aString [

	| stream sign |

	self assertWellFormed: aString.
	stream := (thousandsSeparator withContentDo: [ :sep | aString copyWithout: sep ] ifUnused: [ aString ]) readStream.
	sign := self parseSignFrom: stream.
	^ sign * stream upToEnd asNumber
]

{ #category : #initialization }
ScaledDecimalParser >> parseSignFrom: stream [

	^ stream peek isDigit
		ifTrue: [ 1 ]
		ifFalse: [ stream next = $-
				ifTrue: [ -1 ]
				ifFalse: [ 1 ] ]
]
