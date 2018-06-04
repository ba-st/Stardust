Class {
	#name : #BinaryChoiceModelPicker,
	#superclass : #ModelCreator,
	#instVars : [
		'name',
		'view'
	],
	#category : #'Stardust-ModelCreator'
}

{ #category : #'instance creation' }
BinaryChoiceModelPicker class >> named: aName obtainingSelectionFrom: aBinaryChoiceView [

	self
		assertNotEmpty: aName;
		assert: aBinaryChoiceView implements: ModelCreationAPI >> #BinaryChoice.

	^ self new initializeNamed: aName obtainingSelectionFrom: aBinaryChoiceView
]

{ #category : #testing }
BinaryChoiceModelPicker >> canCreate: aModel [

	^ view allows: aModel
]

{ #category : #accessing }
BinaryChoiceModelPicker >> changeModelTo: anOption in: aContext [

	(self canCreate: anOption)
		ifFalse: [ ObjectNotFound signal: ('<1s> is not a valid option' expandMacrosWith: anOption asString) ].

	view currentSelection = anOption
		ifFalse: [ view toggleCurrentSelection ]
]

{ #category : #enumerating }
BinaryChoiceModelPicker >> dependenciesDo: aBlock [

	
]

{ #category : #initialization }
BinaryChoiceModelPicker >> initializeNamed: aName obtainingSelectionFrom: aBinaryChoiceView [

	name := aName.
	view := aBinaryChoiceView
]

{ #category : #accessing }
BinaryChoiceModelPicker >> modelIn: aContext [

	^ view currentSelection
]

{ #category : #accessing }
BinaryChoiceModelPicker >> name [

	^ name
]

{ #category : #notifying }
BinaryChoiceModelPicker >> notifyChangesTo: aSupervisor [

	aSupervisor relateChangesIn: view withModelFor: self.
	view notifyChangesTo: aSupervisor
]
