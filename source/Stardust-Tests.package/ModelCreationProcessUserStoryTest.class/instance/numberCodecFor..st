private - accessing
numberCodecFor: aTextView

	| textController |

	textController := ContainerController named: 'text' controlling: aTextView.
	^ TextCodec
		workingWith: textController
		parsingWith: NaturalNumberParser new
		formattingWith: NullFormatter new