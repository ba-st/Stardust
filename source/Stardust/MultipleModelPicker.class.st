"
I'm a multiple model picker. 
I interact with some UI component that needs to implement ModelCreationAPI >> #MultipleSelection .
I support the use case of selecting several of the valid options. Typical UI components compatible with me are tables and list boxes.
"
Class {
	#name : #MultipleModelPicker,
	#superclass : #BasicModelCreator,
	#instVars : [
		'view',
		'name',
		'modelPickingPolicy'
	],
	#category : #'Stardust-ModelCreation'
}

{ #category : #'instance creation' }
MultipleModelPicker class >> named: aName obtainingSelectionFrom: aView [

	^ self named: aName obtainingSelectionFrom: aView accordingTo: PickModelPolicy new
]

{ #category : #'instance creation' }
MultipleModelPicker class >> named: aName obtainingSelectionFrom: aView accordingTo: aModelPickingPolicy [

	self
		assertNotEmpty: aName;
		assert: aView implements: ModelCreationAPI >> #MultipleSelection.

	^ self new initializeNamed: aName obtainingSelectionFrom: aView accordingTo: aModelPickingPolicy
]

{ #category : #configuring }
MultipleModelPicker >> allowAnyOf: aCollection [

	view allowAnyOf: aCollection
]

{ #category : #testing }
MultipleModelPicker >> canCreate: aModelCollection [

	^ aModelCollection allSatisfy: [ :aModelElement | view allowsAnySatisfying: [ :uiElement | modelPickingPolicy is: aModelElement equalTo: uiElement ] ]
]

{ #category : #disassembling }
MultipleModelPicker >> changeModelTo: aCollection in: aContext [

	view choose: aCollection matchedUsing: [ :model :selectableElement | modelPickingPolicy is: selectableElement equalTo: model ] ifUnable: [ ObjectNotFound signal: 'Selected elements are not valid' ]
]

{ #category : #configuring }
MultipleModelPicker >> disallowAll [

	view disallowAll
]

{ #category : #initialization }
MultipleModelPicker >> initializeNamed: aName obtainingSelectionFrom: aView accordingTo: aModelPickingPolicy [

	name := aName.
	view := aView.
	modelPickingPolicy := aModelPickingPolicy
]

{ #category : #assembling }
MultipleModelPicker >> modelIn: aContext [

	^ view currentSelection collect: [ :uiElement | modelPickingPolicy pickFrom: uiElement ]
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
