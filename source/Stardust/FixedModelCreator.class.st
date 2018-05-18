Class {
	#name : #FixedModelCreator,
	#superclass : #ModelCreator,
	#instVars : [
		'model'
	],
	#category : 'Stardust-ModelCreator'
}

{ #category : #'instance creation' }
FixedModelCreator class >> creating: aModel [

	^ self new initializeCreating: aModel
]

{ #category : #testing }
FixedModelCreator >> canCreate: aModel [

	^ model = aModel
]

{ #category : #accessing }
FixedModelCreator >> changeModelTo: aModel in: aContext [

	"Como es un modelo fijo no hago nada.
	No devuelvo un ProgrammingError porque un objeto que lo conozca podría estar enviando este mensaje para configurar sus componentes.
	-mtabacman"

	
]

{ #category : #enumerating }
FixedModelCreator >> dependenciesDo: aBlock [

	
]

{ #category : #initialization }
FixedModelCreator >> initializeCreating: aModel [

	model := aModel
]

{ #category : #accessing }
FixedModelCreator >> modelIn: aContext [

	^ model
]

{ #category : #accessing }
FixedModelCreator >> name [

	^ model asString
]

{ #category : #notifying }
FixedModelCreator >> notifyChangesTo: aModelCreationSupervisor [

	
]
