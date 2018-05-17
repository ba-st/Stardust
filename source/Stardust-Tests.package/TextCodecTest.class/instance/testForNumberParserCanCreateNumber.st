tests
testForNumberParserCanCreateNumber

	| creator codec |

	creator := ContainerController named: 'text' controlling: TextInputViewExample new.
	codec := TextCodec workingWith: creator parsingWith: NaturalNumberParser new formattingWith: NullFormatter new.

	self
		assert: (codec canCreate: 4);
		deny: (codec canCreate: 4.5);
		deny: (codec canCreate: String new)