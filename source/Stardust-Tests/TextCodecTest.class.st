Class {
	#name : #TextCodecTest,
	#superclass : #TestCase,
	#category : 'Stardust-Tests-ModelCreator'
}

{ #category : #'private - accessing' }
TextCodecTest >> changeModelFor: aCreator to: aModel [

	aCreator changeModelTo: aModel in: self
]

{ #category : #'private - accessing' }
TextCodecTest >> localeProvider [

	^FixedLocaleProvider providing: (
		MCPConfigurableLocale
			thousandsSeparator: (PluggableSeparator printing: $.)
			decimalSeparator: (PluggableSeparator printing: $,))
]

{ #category : #'private - accessing' }
TextCodecTest >> modelFor: aCreator [

	^ aCreator modelIn: self
]

{ #category : #'private - accessing' }
TextCodecTest >> numberFormatter [

	^MCPFixDecimalsRealNumberFormatter numberOfDecimalPlaces: 2 localeProvidedBy: self localeProvider
]

{ #category : #tests }
TextCodecTest >> testForDateParserCanCreateDate [

	| creator codec |

	creator := ContainerController named: 'text' controlling: TextInputViewExample new.
	codec := TextCodec workingWith: creator parsingWith: ISO8601DateParser new formattingWith: ISO8601DateFormatter new.

	self assert: (codec canCreate: Date today)
]

{ #category : #tests }
TextCodecTest >> testForNumberParserCanCreateNumber [

	| creator codec |

	creator := ContainerController named: 'text' controlling: TextInputViewExample new.
	codec := TextCodec workingWith: creator parsingWith: NaturalNumberParser new formattingWith: NullFormatter new.

	self
		assert: (codec canCreate: 4);
		deny: (codec canCreate: 4.5);
		deny: (codec canCreate: String new)
]

{ #category : #tests }
TextCodecTest >> testForStringParserCanCreateString [

	| creator codec |

	creator := ContainerController named: 'text' controlling: TextInputViewExample new.
	codec := TextCodec workingWith: creator parsingWith: NullParser new formattingWith: NullFormatter new.

	self
		assert: (codec canCreate: 'a text');
		assert: (codec canCreate: String new);
		deny: (codec canCreate: 4)
]

{ #category : #tests }
TextCodecTest >> testFormatterIsUsedToSetViewContents [

	| creator codec |

	creator := ContainerController named: 'text' controlling: TextInputViewExample new.
	codec := TextCodec workingWith: creator parsingWith: NumberParser new formattingWith: NullFormatter new.
	codec changeModelTo: 45.1234 in: self.
	self assert: (creator modelIn: self) equals: '45.1234'
]

{ #category : #tests }
TextCodecTest >> testInvalidParsingExceptionIsRaisedWhenViewContentsIsNotValid [

	| view creator codec |

	view := TextInputViewExample new.
	creator := ContainerController named: 'text' controlling: view.
	codec := TextCodec workingWith: creator parsingWith: NaturalNumberParser new formattingWith: NullFormatter new.
	view changeContentsTo: '1.234.5678'.
	self should: [ codec modelIn: self ] raise: ParsingFailed
]

{ #category : #tests }
TextCodecTest >> testParserIsUsedToObtainViewContents [

	| view creator codec |

	view := TextInputViewExample new.
	creator := ContainerController named: 'text' controlling: view.
	codec := TextCodec workingWith: creator parsingWith: ScaledDecimalParser new formattingWith: NullFormatter new.
	view changeContentsTo: '1234.5678'.
	self assert: (codec modelIn: self) equals: 1234.5678
]
