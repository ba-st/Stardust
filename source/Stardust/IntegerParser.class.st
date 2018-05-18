Class {
	#name : #IntegerParser,
	#superclass : #Object,
	#instVars : [
		'thousandsSeparator'
	],
	#category : 'Stardust-Parser'
}

{ #category : #'instance creation' }
IntegerParser class >> new [

	^ self thousandsSeparatedAcordingTo: Optional unused
]

{ #category : #'private-instance creation' }
IntegerParser class >> thousandsSeparatedAcordingTo: aThousandsOptional [

	^ super new initializeWithThousandsSeparatedAcordingTo: aThousandsOptional
]

{ #category : #'instance creation' }
IntegerParser class >> withThousandsSeparator: aCharacter [

	^ self thousandsSeparatedAcordingTo: (Optional containing: aCharacter)
]

{ #category : #private }
IntegerParser >> assertWellFormed: aString [

	AssertionCheckerBuilder new
		raising: (ParsingFailedFactory parsing: aString);
		checking: [ :mayBeEmpty | 
			mayBeEmpty
				refuse: [ aString isEmpty ]
				because: 'Empty string is not an integer'
				onSuccess: [ :asserter | 
					asserter
						enforce: [ aString first isDigit | (aString first = $+) | (aString first = $-) ]
						because: ('First character of an integer is either a digit, + or -, not <1s>' expandMacrosWith: aString first asString).
					thousandsSeparator
						withContentDo: [ :separator | 
							asserter
								enforce: [ self is: aString allButFirst separatedByThousandsWith: separator ]
								because: ('An integer only contains digits separated every third decimal place with: <1p> optionally prepended by + or -' expandMacrosWith: separator) ]
						ifUnused: [ asserter enforce: [ aString allButFirst allSatisfy: #isDigit ] because: 'An integer only contains digits optionally prepended by + or -' ] ] ];
		buildAndCheck
]

{ #category : #initialization }
IntegerParser >> initializeWithThousandsSeparatedAcordingTo: aThousandsOptional [

	thousandsSeparator := aThousandsOptional
]

{ #category : #private }
IntegerParser >> is: aNumberString separatedByThousandsWith: separator [

	"Backwards (in ascending significance), every 4th must be the separator, all the others must be digits"

	| reversedNumber |

	reversedNumber := aNumberString reversed.
	^ reversedNumber
		allSatisfy: [ :c | 
			(reversedNumber indexOf: c) \\ 4 = 0
				ifTrue: [ c = separator ]
				ifFalse: [ c isDigit ] ]
]

{ #category : #parsing }
IntegerParser >> parse: aString [

	| stream sign |

	self assertWellFormed: aString.
	stream := (thousandsSeparator withContentDo: [ :sep | aString copyWithout: sep ] ifUnused: [ aString ]) readStream.
	sign := self parseSignFrom: stream.
	^ sign * stream upToEnd asNumber
]

{ #category : #parsing }
IntegerParser >> parseSignFrom: stream [

	^ stream peek isDigit
		ifTrue: [ 1 ]
		ifFalse: [ stream next = $-
				ifTrue: [ -1 ]
				ifFalse: [ 1 ] ]
]
