tests
testParserIsUsedToObtainViewContents

	| view creator codec |

	view := TextInputViewExample new.
	creator := ContainerController named: 'text' controlling: view.
	codec := TextCodec workingWith: creator parsingWith: ScaledDecimalParser new formattingWith: NullFormatter new.
	view changeContentsTo: '1234.5678'.
	self assert: (codec modelIn: self) equals: 1234.5678