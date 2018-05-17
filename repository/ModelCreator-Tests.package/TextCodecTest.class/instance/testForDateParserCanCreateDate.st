tests
testForDateParserCanCreateDate

	| creator codec |

	creator := ContainerController named: 'text' controlling: TextInputViewExample new.
	codec := TextCodec workingWith: creator parsingWith: ISO8601DateParser new formattingWith: ISO8601DateFormatter new.

	self assert: (codec canCreate: Date today)