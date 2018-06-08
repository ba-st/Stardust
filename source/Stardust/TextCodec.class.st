"
I'm a composite model creator. I can create a model parsing the string provided by the creator I know, and do the opposite formatting some object into a string.
"
Class {
	#name : #TextCodec,
	#superclass : #CompositeModelCreator,
	#instVars : [
		'textCreator',
		'decodingBlock',
		'encodingBlock'
	],
	#category : #Stardust
}

{ #category : #'instance creation' }
TextCodec class >> workingWith: aCreator decodingWith: aDecodingBlock encodingWith: anEncodingBlock [

	^ self new initializeWorkingWith: aCreator decodingWith: aDecodingBlock encodingWith: anEncodingBlock
]

{ #category : #'instance creation' }
TextCodec class >> workingWith: aCreator parsingWith: aParser formattingWith: aFormatter [

	^ self workingWith: aCreator decodingWith: [ :string | aParser parse: string ] encodingWith: [ :object | aFormatter format: object ]
]

{ #category : #testing }
TextCodec >> canCreate: anObject [

	^ [ (decodingBlock value: (encodingBlock value: anObject)) = anObject ]
		on: InstanceCreationFailed , DecodingFailed
		do: [ :aSignal | aSignal return: false ]
]

{ #category : #disassembling }
TextCodec >> changeModelTo: aModel in: aContext [

	aContext changeModelFor: textCreator to: (encodingBlock value: aModel)
]

{ #category : #enumerating }
TextCodec >> dependenciesDo: aBlock [

	^ aBlock value: textCreator
]

{ #category : #initialization }
TextCodec >> initializeWorkingWith: aCreator decodingWith: aDecodingBlock encodingWith: anEncodingBlock [

	textCreator := aCreator.
	decodingBlock := aDecodingBlock.
	encodingBlock := anEncodingBlock
]

{ #category : #assembling }
TextCodec >> modelIn: aContext [

	^ [ decodingBlock value: (aContext modelFor: textCreator) ]
		on: DecodingFailed
		do: [ :signal | InstanceCreationFailed signal: signal messageText ]
]

{ #category : #accessing }
TextCodec >> name [

	^ textCreator name
]

{ #category : #printing }
TextCodec >> printOn: aStream [

	aStream nextPutAll: ('Codec for <1s>' expandMacrosWith: self name)
]
