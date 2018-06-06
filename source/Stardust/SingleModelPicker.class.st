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

{ #category : #'selection protocol' }
SingleModelPicker >> allowAnyOf: anOptionCollection [

	view allowAnyOf: anOptionCollection
]

{ #category : #testing }
SingleModelPicker >> canCreate: aModel [

	^ view allowsAnySatisfying: [ :element | pickingPolicy is: element equalTo: aModel ]
]

{ #category : #accessing }
SingleModelPicker >> changeModelTo: anOption in: aContext [

	view
		chooseAnySatisfying: [ :element | pickingPolicy is: element equalTo: anOption ]
		ifNone: [ ObjectNotFound signal: ('<1s> is not a valid option' expandMacrosWith: anOption asString) ]
]

{ #category : #'selection protocol' }
SingleModelPicker >> disallowAll [

	view disallowAll
]

{ #category : #initialization }
SingleModelPicker >> initializeNamed: aName obtainingSelectionFrom: aSingleSelectionView accordingTo: aModelPickingPolicy [

	name := aName.
	view := aSingleSelectionView.
	"Esto deberÌa morir cuando se dejen de usar los UI representation adentro de las selecciones. Para eso est· el LabelingCommand - gabriel"
	pickingPolicy := aModelPickingPolicy
]

{ #category : #accessing }
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
