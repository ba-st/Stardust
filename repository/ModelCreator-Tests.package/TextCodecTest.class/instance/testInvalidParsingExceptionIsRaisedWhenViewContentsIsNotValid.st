tests
testInvalidParsingExceptionIsRaisedWhenViewContentsIsNotValid

	| view creator codec |

	view := TextInputViewExample new.
	creator := ContainerController named: 'text' controlling: view.
	codec := TextCodec workingWith: creator parsingWith: NaturalNumberParser new formattingWith: NullFormatter new.
	view changeContentsTo: '1.234.5678'.
	self should: [ codec modelIn: self ] raise: ParsingFailed