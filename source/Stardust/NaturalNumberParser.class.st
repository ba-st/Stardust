Class {
	#name : #NaturalNumberParser,
	#superclass : #Object,
	#instVars : [
		'thousandsSeparator'
	],
	#category : 'Stardust-Parser'
}

{ #category : #'instance creation' }
NaturalNumberParser class >> new [

	^ self thousandsSeparatedAcordingTo: Optional unused
]

{ #category : #'private-instance creation' }
NaturalNumberParser class >> thousandsSeparatedAcordingTo: aThousandsOptional [

	^ super new initializeWithThousandsSeparatedAcordingTo: aThousandsOptional
]

{ #category : #'instance creation' }
NaturalNumberParser class >> withThousandsSeparator: aCharacter [

	^ self thousandsSeparatedAcordingTo: (Optional containing: aCharacter)
]

{ #category : #parsing }
NaturalNumberParser >> assertWellFormed: aString [

	AssertionCheckerBuilder new
		raising: (ParsingFailedFactory parsing: aString);
		checking: [ :mayBeEmpty | 
			mayBeEmpty
				refuse: [ aString isEmpty ]
				because: 'Empty string is not a natural number'
				onSuccess: [ :asserter | 
					thousandsSeparator
						withContentDo:
							[ :separator | asserter enforce: [ self is: aString separatedByThousandsWith: separator ] because: ('An natural number only contains digits separated every third decimal place with: <1p>' expandMacrosWith: separator) ]
						ifUnused: [ asserter enforce: [ aString allSatisfy: #isDigit ] because: 'An natural number only contains digits' ] ] ];
		buildAndCheck
]

{ #category : #parsing }
NaturalNumberParser >> initializeWithThousandsSeparatedAcordingTo: anOptional [

	thousandsSeparator := anOptional
]

{ #category : #testing }
NaturalNumberParser >> is: aNumberString separatedByThousandsWith: separator [

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
NaturalNumberParser >> parse: aString [

	self assertWellFormed: aString.
	^ (thousandsSeparator withContentDo: [ :separator | aString copyWithout: separator ] ifUnused: [ aString ]) asNumber
]
