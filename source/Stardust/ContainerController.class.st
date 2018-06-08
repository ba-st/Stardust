"
I'm a container controller. 
I interact with some UI component that needs to implement ModelCreationAPI >> #Container .
I support the use case of returning an object contained in some UI component. Typical UI components compatible with me are tables, text fields and lists.
"
Class {
	#name : #ContainerController,
	#superclass : #ModelCreator,
	#instVars : [
		'view',
		'name'
	],
	#category : #Stardust
}

{ #category : #'instance creation' }
ContainerController class >> named: aName controlling: aView [

	self
		assertNotEmpty: aName;
		assert: aView implements: ModelCreationAPI >> #Container.
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
