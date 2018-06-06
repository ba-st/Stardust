"
I'm a fixed model creator. 
I don't interact with any UI component, just returns the model previosuly configured on me.
"
Class {
	#name : #FixedModelCreator,
	#superclass : #BasicModelCreator,
	#instVars : [
		'model'
	],
	#category : #'Stardust-ModelCreation'
}

{ #category : #'instance creation' }
FixedModelCreator class >> creating: aModel [

	^ self new initializeCreating: aModel
]

{ #category : #testing }
FixedModelCreator >> canCreate: aModel [

	^ model = aModel
]

{ #category : #disassembling }
FixedModelCreator >> changeModelTo: aModel in: aContext [

	"I never change the model I know"

	
]

{ #category : #initialization }
FixedModelCreator >> initializeCreating: aModel [

	model := aModel
]

{ #category : #assembling }
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
