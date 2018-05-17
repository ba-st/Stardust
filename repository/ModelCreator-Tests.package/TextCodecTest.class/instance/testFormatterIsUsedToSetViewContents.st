tests
testFormatterIsUsedToSetViewContents

	| creator codec |

	creator := ContainerController named: 'text' controlling: TextInputViewExample new.
	codec := TextCodec workingWith: creator parsingWith: NumberParser new formattingWith: NullFormatter new.
	codec changeModelTo: 45.1234 in: self.
	self assert: (creator modelIn: self) equals: '45.1234'