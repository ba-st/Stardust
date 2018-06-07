"
I'm a test case
"
Class {
	#name : #TextCodecTest,
	#superclass : #ModelCreatorTest,
	#instVars : [
		'textField',
		'containerController'
	],
	#category : #'Stardust-Tests-ModelCreation'
}

{ #category : #'private - accessing' }
TextCodecTest >> numberDecoding [

	^ [ :string | 
	[ Number readFrom: string ]
		on: Error
		do: [ :error | DecodingFailed signal: error messageText ] ]
]

{ #category : #running }
TextCodecTest >> setUp [

	super setUp.
	textField := self textField.
	containerController := ContainerController named: 'Text' controlling: textField
]

{ #category : #tests }
TextCodecTest >> testDecodingActionIsUsedToObtainViewContents [

	| codec |

	codec := TextCodec workingWith: containerController decodingWith: self numberDecoding encodingWith: [ :number | number printString ].
	context changeModelFor: containerController to: '1234.5678'.

	self assert: (codec modelIn: context) equals: 1234.5678
]

{ #category : #tests }
TextCodecTest >> testEncodingActionIsUsedToSetViewContents [

	| codec |

	codec := TextCodec workingWith: containerController decodingWith: self numberDecoding encodingWith: [ :number | number printString ].

	codec changeModelTo: 45.1234 in: context.

	self
		assert: (codec modelIn: context) equals: 45.1234;
		assert: (containerController modelIn: context) equals: '45.1234'
]

{ #category : #tests }
TextCodecTest >> testForNumberParserCanCreateNumber [

	| codec |

	codec := TextCodec workingWith: containerController decodingWith: self numberDecoding encodingWith: [ :number | number printString ].

	self
		assert: (codec canCreate: 4);
		assert: (codec canCreate: 4.5);
		deny: (codec canCreate: '')
]

{ #category : #tests }
TextCodecTest >> testForStringParserCanCreateString [

	| codec |

	codec := TextCodec workingWith: containerController decodingWith: [ :string | string ] encodingWith: [ :object | object asString ].
	self
		assert: (codec canCreate: 'a text');
		assert: (codec canCreate: '');
		deny: (codec canCreate: 4)
]

{ #category : #tests }
TextCodecTest >> testModelCreationFailedWhenViewContentsIsNotValid [

	| codec |

	codec := TextCodec workingWith: containerController decodingWith: self numberDecoding encodingWith: [ :number | number printString ].
	context changeModelFor: containerController to: 'AAAZ'.

	self should: [ codec modelIn: context ] raise: InstanceCreationFailed
]
