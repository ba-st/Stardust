tests
testForStringParserCanCreateString

	| creator codec |

	creator := ContainerController named: 'text' controlling: TextInputViewExample new.
	codec := TextCodec workingWith: creator parsingWith: NullParser new formattingWith: NullFormatter new.

	self
		assert: (codec canCreate: 'a text');
		assert: (codec canCreate: String new);
		deny: (codec canCreate: 4)