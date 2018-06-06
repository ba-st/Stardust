"
I'm a binary choice picker. 
I interact with some UI component that needs to implement ModelCreationAPI >> #BinaryChoice .
I support the use case of selecting one of two valid options. Typical UI components compatible with me are toggles and check boxes.
"
Class {
	#name : #BinaryChoiceModelPicker,
	#superclass : #BasicModelCreator,
	#instVars : [
		'name',
		'view'
	],
	#category : #'Stardust-ModelCreation'
}

{ #category : #'instance creation' }
BinaryChoiceModelPicker class >> named: aName obtainingSelectionFrom: aBinaryChoiceUIComponent [

	self
		assertNotEmpty: aName;
		assert: aBinaryChoiceUIComponent implements: ModelCreationAPI >> #BinaryChoice.

	^ self new initializeNamed: aName obtainingSelectionFrom: aBinaryChoiceUIComponent
]

{ #category : #testing }
BinaryChoiceModelPicker >> canCreate: aModel [

	^ view allows: aModel
]

{ #category : #disassembling }
BinaryChoiceModelPicker >> changeModelTo: anOption in: aContext [

	(self canCreate: anOption)
		ifFalse: [ ObjectNotFound signal: ('<1s> is not a valid option' expandMacrosWith: anOption asString) ].

	view currentSelection = anOption
		ifFalse: [ view toggleCurrentSelection ]
]

{ #category : #initialization }
BinaryChoiceModelPicker >> initializeNamed: aName obtainingSelectionFrom: aBinaryChoiceView [

	name := aName.
	view := aBinaryChoiceView
]

{ #category : #assembling }
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
