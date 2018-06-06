"
I'm a single model picker. 
I interact with some UI component that needs to implement ModelCreationAPI >> #SingleSelection .
I support the use case of selecting one of many valid options. Typical UI components compatible with me are dropdown lists, tables and combo boxes.
"
Class {
	#name : #SingleModelPicker,
	#superclass : #BasicModelCreator,
	#instVars : [
		'view',
		'name',
		'pickingPolicy'
	],
	#category : #'Stardust-ModelCreation'
}

{ #category : #'instance creation' }
SingleModelPicker class >> named: aName obtainingSelectionFrom: aSingleSelectionView [

	self
		deprecated:
			'Deberiamos eliminar el uso de los UIRepresentation,
			todas las view de selection tienen alguna forma de configurarles que mostrar, generalmente usando el ListLabelingCommand.
			Cuando se eliminen los usos se puede borrar la jerarquia de ModelPickingPolicy'.

	^ self named: aName obtainingSelectionFrom: aSingleSelectionView accordingTo: PickUIRepresentationPolicy new
]

{ #category : #'private-instance creation' }
SingleModelPicker class >> named: aName obtainingSelectionFrom: aSingleSelectionView accordingTo: aModelPickingPolicy [

	self
		assertNotEmpty: aName;
		assert: aSingleSelectionView implements: ModelCreationAPI >> #SingleSelection.
	^ self new initializeNamed: aName obtainingSelectionFrom: aSingleSelectionView accordingTo: aModelPickingPolicy
]

{ #category : #'instance creation' }
SingleModelPicker class >> named: aName pickingFrom: aSingleSelectionView [

	^ self named: aName obtainingSelectionFrom: aSingleSelectionView accordingTo: PickModelPolicy new
]

{ #category : #configuring }
SingleModelPicker >> allowAnyOf: validOptions [

	view allowAnyOf: validOptions
]

{ #category : #testing }
SingleModelPicker >> canCreate: aModel [

	^ view allowsAnySatisfying: [ :uiElement | pickingPolicy is: uiElement equalTo: aModel ]
]

{ #category : #disassembling }
SingleModelPicker >> changeModelTo: anOption in: aContext [

	view
		chooseAnySatisfying: [ :element | pickingPolicy is: element equalTo: anOption ]
		ifNone: [ ObjectNotFound signal: ('<1s> is not a valid option' expandMacrosWith: anOption asString) ]
]

{ #category : #configuring }
SingleModelPicker >> disallowAll [

	view disallowAll
]

{ #category : #initialization }
SingleModelPicker >> initializeNamed: aName obtainingSelectionFrom: aSingleSelectionView accordingTo: aModelPickingPolicy [

	name := aName.
	view := aSingleSelectionView.
	pickingPolicy := aModelPickingPolicy
]

{ #category : #assembling }
SingleModelPicker >> modelIn: aContext [

	^ pickingPolicy pickFrom: (view currentSelectionIfNone: [ ModelCreationFailed signal: 'A valid element must be selected' ])
]

{ #category : #accessing }
SingleModelPicker >> name [

	^ name
]

{ #category : #notifying }
SingleModelPicker >> notifyChangesTo: aSupervisor [

	aSupervisor relateChangesIn: view withModelFor: self.
	view notifyChangesTo: aSupervisor
]
