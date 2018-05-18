Class {
	#name : #TextCodec,
	#superclass : #ModelCreator,
	#instVars : [
		'creator',
		'parser',
		'formatter'
	],
	#category : 'Stardust-ModelCreator'
}

{ #category : #'instance creation' }
TextCodec class >> workingWith: aCreator parsingWith: aParser formattingWith: aFormatter [

	^ self new initializeWorkingWith: aCreator parsingWith: aParser formattingWith: aFormatter
]

{ #category : #testing }
TextCodec >> canCreate: anObject [

	^ [ (parser parse: (formatter format: anObject)) = anObject ]
		on: InstanceCreationFailed , ParsingFailed
		do: [ :aSignal | aSignal return: false ]
]

{ #category : #accessing }
TextCodec >> changeModelTo: aModel in: aContext [

	aContext changeModelFor: creator to: (formatter format: aModel)
]

{ #category : #enumerating }
TextCodec >> dependenciesDo: aBlock [

	^ aBlock value: creator
]

{ #category : #initialization }
TextCodec >> initializeWorkingWith: aCreator parsingWith: aParser formattingWith: aFormatter [

	creator := aCreator.
	parser := aParser.
	formatter := aFormatter
]

{ #category : #accessing }
TextCodec >> modelIn: aContext [

	^ parser parse: (aContext modelFor: creator)
]

{ #category : #accessing }
TextCodec >> name [

	^ creator name
]

{ #category : #notifying }
TextCodec >> notifyChangesTo: aSupervisor [

	
]

{ #category : #printing }
TextCodec >> printOn: aStream [

	aStream nextPutAll: ('Codec para <1s>' expandMacrosWith: self name)
]
