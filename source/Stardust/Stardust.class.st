"
I'm a Shared Pool proving access to some well known objects
"
Class {
	#name : #Stardust,
	#superclass : #SharedPool,
	#classVars : [
		'ModelCreationAPI'
	],
	#category : #'Stardust-ModelCreation'
}

{ #category : #'class initialization' }
Stardust class >> initialize [

	<ignoreForCoverage>
	ModelCreationAPI := Namespace new.
	self
		initializeSingleSelectionAPI;
		initializeMultipleSelectionAPI;
		initializeContainerAPI;
		initializeBinaryChoiceAPI
]

{ #category : #'class initialization' }
Stardust class >> initializeBinaryChoiceAPI [

	<ignoreForCoverage>
	ModelCreationAPI
		bind: #BinaryChoice
		to: (Interface named: #BinaryChoice declaring: #(#toggleCurrentSelection #currentSelection #notifyChangesTo: #allows:))
]

{ #category : #'class initialization' }
Stardust class >> initializeContainerAPI [

	<ignoreForCoverage>
	ModelCreationAPI bind: #Container to: (Interface named: #Container declaring: #(#changeContentsTo: #contents #notifyChangesTo:))
]

{ #category : #'class initialization' }
Stardust class >> initializeMultipleSelectionAPI [

	<ignoreForCoverage>
	ModelCreationAPI
		bind: #MultipleSelection
		to:
			(Interface
				named: #MultipleSelection
				declaring: #(#disallowAll #allowAnyOf: #currentSelection #allowAnySatisfying: #notifyChangesTo: #chooseAll #choose:matchedUsing:ifUnable:))
]

{ #category : #'class initialization' }
Stardust class >> initializeSingleSelectionAPI [

	<ignoreForCoverage>
	ModelCreationAPI
		bind: #SingleSelection
		to:
			(Interface
				named: #SingleSelection
				declaring: #(#disallowAll #allowAnyOf: #currentSelectionIfNone: #chooseAnySatisfying:ifNone: #notifyChangesTo: #allowsAnySatisfying:))
]
