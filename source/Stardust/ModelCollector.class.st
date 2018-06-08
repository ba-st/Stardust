"
I'm a composite model creator. I'm responsible for creating a collection containing the models provided by the creators given to me.
"
Class {
	#name : #ModelCollector,
	#superclass : #CompositeModelCreator,
	#instVars : [
		'modelCreators',
		'name'
	],
	#category : #Stardust
}

{ #category : #'instance creation' }
ModelCollector class >> named: aName containing: anCollectionOfModelCreators [

	self assertNotEmpty: aName.
	^ self new initializeNamed: aName containing: anCollectionOfModelCreators
]

{ #category : #disassembling }
ModelCollector >> changeModelTo: aModelCollection in: aContext [

	modelCreators with: aModelCollection do: [ :modelCreator :model | aContext changeModelFor: modelCreator to: model ]
]

{ #category : #enumerating }
ModelCollector >> dependenciesDo: aBlock [

	^ modelCreators do: aBlock
]

{ #category : #initialization }
ModelCollector >> initializeNamed: aName containing: anCollectionOfModelCreators [

	name := aName.
	modelCreators := anCollectionOfModelCreators
]

{ #category : #assembling }
ModelCollector >> modelIn: aContext [

	^ modelCreators collect: [ :modelCreator | aContext modelFor: modelCreator ]
]

{ #category : #accessing }
ModelCollector >> name [

	^ name
]
