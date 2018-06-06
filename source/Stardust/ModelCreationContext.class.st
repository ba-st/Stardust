"
I'm a context used for creating a model under the supervision of a ModelSupervisor. I'm responsible for keeping track of the objects built by each creator, in order to avoid having to build it twice if no changes were made.

I'm a private class not intended to be used outside the library.
"
Class {
	#name : #ModelCreationContext,
	#superclass : #Object,
	#instVars : [
		'knownModels'
	],
	#category : #'Stardust-ModelCreation'
}

{ #category : #'instance creation' }
ModelCreationContext class >> new [

	^ super new initialize
]

{ #category : #disassembling }
ModelCreationContext >> changeModelFor: aCreator to: aModel [

	knownModels at: aCreator put: aModel.
	aCreator changeModelTo: aModel in: self
]

{ #category : #initialization }
ModelCreationContext >> initialize [

	super initialize.
	knownModels := IdentityDictionary new
]

{ #category : #invalidating }
ModelCreationContext >> invalidateModelFor: aCreator [

	knownModels removeKey: aCreator ifAbsent: [  ]
]

{ #category : #accessing }
ModelCreationContext >> modelFor: aCreator [

	^ knownModels at: aCreator ifAbsent: [ ModelInContextNotFound signal: (#'Model of <1s> not found (<2p>)' expandMacrosWith: aCreator name with: aCreator) ]
]

{ #category : #assembling }
ModelCreationContext >> modelInSequenceFor: aCreator [

	^ knownModels at: aCreator ifAbsentPut: [ aCreator modelIn: self ]
]
