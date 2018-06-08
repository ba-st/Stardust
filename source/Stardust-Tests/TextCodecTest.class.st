"
I'm a test case
"
Class {
	#name : #TextCodecTest,
	#superclass : #CompositeModelCreatorTest,
	#instVars : [
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
	containerController := self newContainerControllerNamed: 'Text'
]

{ #category : #tests }
TextCodecTest >> testDecodingActionIsUsedToObtainViewContents [

	| codec |

	codec := TextCodec workingWith: containerController decodingWith: self numberDecoding encodingWith: [ :number | number printString ].
	containerController updateModelInViewsConsidering: '1234.5678'.

	self assertModelAssembledBy: codec equals: 1234.5678
]

{ #category : #tests }
TextCodecTest >> testEncodingActionIsUsedToSetViewContents [

	| codec |

	codec := TextCodec workingWith: containerController decodingWith: self numberDecoding encodingWith: [ :number | number printString ].

	self assertModelAssembledBy: containerController equals: ''.

	codec updateModelInViewsConsidering: 45.1234.

	self
		assertModelAssembledBy: codec equals: 45.1234;
		assertModelAssembledBy: containerController equals: '45.1234'
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

	containerController updateModelInViewsConsidering: 'AAAZ'.

	self assertModelCreationFailedFor: codec
]
