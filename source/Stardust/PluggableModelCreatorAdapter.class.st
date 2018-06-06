Class {
	#name : #PluggableModelCreatorAdapter,
	#superclass : #Object,
	#instVars : [
		'creator',
		'adaptingBlock'
	],
	#category : #'Stardust-ModelCreation'
}

{ #category : #'instance creation' }
PluggableModelCreatorAdapter class >> adapting: aCreator with: aBlock [

	^ self new initializeAdapting: aCreator with: aBlock
]

{ #category : #enumerating }
PluggableModelCreatorAdapter >> dependenciesDo: aBlock [

	^ aBlock value: creator
]

{ #category : #initialization }
PluggableModelCreatorAdapter >> initializeAdapting: aCreator with: aBlock [

	creator := aCreator.
	adaptingBlock := aBlock
]

{ #category : #accessing }
PluggableModelCreatorAdapter >> modelIn: aContext [

	^ adaptingBlock value: (aContext modelFor: creator)
]

{ #category : #notifying }
PluggableModelCreatorAdapter >> notifyChangesTo: aSupervisor [

	
]
