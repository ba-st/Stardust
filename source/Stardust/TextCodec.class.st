"
I'm a composite model creator. I can create a model parsing the string provided by the creator I know, and do the opposite formatting some object into a string.
"
Class {
	#name : #TextCodec,
	#superclass : #ModelCreator,
	#instVars : [
		'decodingAction',
		'encodingAction',
		'textCreator'
	],
	#category : #'Stardust-ModelCreation'
}

{ #category : #'instance creation' }
TextCodec class >> workingWith: aCreator decodingWith: aDecodingAction encodingWith: anEncodingAction [

	^ self new initializeWorkingWith: aCreator decodingWith: aDecodingAction encodingWith: anEncodingAction
]

{ #category : #'instance creation' }
TextCodec class >> workingWith: aCreator parsingWith: aParser formattingWith: aFormatter [

	^ self workingWith: aCreator decodingWith: [ :string | aParser parse: string ] encodingWith: [ :object | aFormatter format: object ]
]

{ #category : #testing }
TextCodec >> canCreate: anObject [

	^ [ (decodingAction value: (encodingAction value: anObject)) = anObject ]
		on: InstanceCreationFailed , DecodingFailed
		do: [ :aSignal | aSignal return: false ]
]

{ #category : #disassembling }
TextCodec >> changeModelTo: aModel in: aContext [

	aContext changeModelFor: textCreator to: (encodingAction value: aModel)
]

{ #category : #enumerating }
TextCodec >> dependenciesDo: aBlock [

	^ aBlock value: textCreator
]

{ #category : #initialization }
TextCodec >> initializeWorkingWith: aCreator decodingWith: aDecodingAction encodingWith: anEcodingAction [

	textCreator := aCreator.
	decodingAction := aDecodingAction.
	encodingAction := anEcodingAction
]

{ #category : #assembling }
TextCodec >> modelIn: aContext [

	^ [ decodingAction value: (aContext modelFor: textCreator) ]
		on: DecodingFailed
		do: [ :signal | ModelCreationFailed signal: signal messageText ]
]

{ #category : #accessing }
TextCodec >> name [

	^ textCreator name
]

{ #category : #notifying }
TextCodec >> notifyChangesTo: aSupervisor [

	
]

{ #category : #printing }
TextCodec >> printOn: aStream [

	aStream nextPutAll: ('Codec para <1s>' expandMacrosWith: self name)
]
