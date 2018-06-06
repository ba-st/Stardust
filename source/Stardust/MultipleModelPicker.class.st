Class {
	#name : #MultipleModelPicker,
	#superclass : #BasicModelCreator,
	#instVars : [
		'view',
		'name'
	],
	#category : #'Stardust-ModelCreation'
}

{ #category : #'instance creation' }
MultipleModelPicker class >> named: aName obtainingSelectionFrom: aView [


	self
		assertNotEmpty: aName;
		assert: aView implements: ModelCreationAPI >> #MultipleSelection.

	^ self new initializeNamed: aName obtainingSelectionFrom: aView
]

{ #category : #'selection protocol' }
MultipleModelPicker >> allowAnyOf: aCollection [

	view allowAnyOf: aCollection
]

{ #category : #testing }
MultipleModelPicker >> canCreate: aModelCollection [

	^ aModelCollection allSatisfy: [ :aModelElement | view allowsAnySatisfying: [ :element | element representedObject = aModelElement ] ]
]

{ #category : #accessing }
MultipleModelPicker >> changeModelTo: aCollection in: aContext [

	view
		choose: aCollection
		matchedUsing: [ :model :selectableElement | model = selectableElement representedObject ]
		ifUnable: [ ObjectNotFound signal: 'Selected elements are not valid' ]
]

{ #category : #'selection protocol' }
MultipleModelPicker >> disallowAll [

	view disallowAll
]

{ #category : #initialization }
MultipleModelPicker >> initializeNamed: aName obtainingSelectionFrom: aView [

	name := aName.
	view := aView
]

{ #category : #accessing }
MultipleModelPicker >> modelIn: aContext [

	^ view currentSelection collect: [ :element | element representedObject ]
]

{ #category : #accessing }
MultipleModelPicker >> name [

	^ name
]

{ #category : #notifying }
MultipleModelPicker >> notifyChangesTo: aSupervisor [

	aSupervisor relateChangesIn: view withModelFor: self.
	view notifyChangesTo: aSupervisor
]
