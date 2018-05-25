Class {
	#name : #ContainerController,
	#superclass : #ModelCreator,
	#instVars : [
		'view',
		'name'
	],
	#category : #'Stardust-ModelCreator'
}

{ #category : #'instance creation' }
ContainerController class >> named: aName controlling: aView [

	self assertNotEmpty: aName.
	^ self new initializeNamed: aName controlling: aView
]

{ #category : #testing }
ContainerController >> canCreate: aModel [

	^ true
]

{ #category : #accessing }
ContainerController >> changeModelTo: aModel in: aContent [

	view changeContentsTo: aModel
]

{ #category : #enumerating }
ContainerController >> dependenciesDo: aBlock [

	
]

{ #category : #initialization }
ContainerController >> initializeNamed: aName controlling: aView [

	name := aName.
	view := aView
]

{ #category : #accessing }
ContainerController >> modelIn: aContext [

	^ view contents
]

{ #category : #accessing }
ContainerController >> name [

	^ name
]

{ #category : #notifying }
ContainerController >> notifyChangesTo: aSupervisor [

	aSupervisor relateChangesIn: (view notifyChangesTo: aSupervisor) withModelFor: self
]
