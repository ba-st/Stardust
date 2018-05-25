Class {
	#name : #ModelCollector,
	#superclass : #ModelCreator,
	#instVars : [
		'modelCreators',
		'name'
	],
	#category : #'Stardust-ModelCreator'
}

{ #category : #'instance creation' }
ModelCollector class >> named: aName containing: anCollectionOfModelCreators [

	self assertNotEmpty: aName.
	^ self new initializeNamed: aName containing: anCollectionOfModelCreators
]

{ #category : #accessing }
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

{ #category : #accessing }
ModelCollector >> modelIn: aContext [

	^ modelCreators collect: [ :modelCreator | aContext modelFor: modelCreator ]
]

{ #category : #accessing }
ModelCollector >> name [

	^ name
]

{ #category : #notifying }
ModelCollector >> notifyChangesTo: aSupervisor [

	
]
