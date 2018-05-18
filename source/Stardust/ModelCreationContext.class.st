Class {
	#name : #ModelCreationContext,
	#superclass : #Object,
	#instVars : [
		'knownModels'
	],
	#category : 'Stardust-ModelCreator'
}

{ #category : #'instance creation' }
ModelCreationContext class >> new [

	^ super new initialize
]

{ #category : #accessing }
ModelCreationContext >> changeModelFor: aCreator to: aModel [

	knownModels at: aCreator put: aModel.
	aCreator changeModelTo: aModel in: self
]

{ #category : #accessing }
ModelCreationContext >> initialize [

	super initialize.
	knownModels := IdentityDictionary new
]

{ #category : #private }
ModelCreationContext >> invalidateModelFor: aCreator [

	knownModels removeKey: aCreator ifAbsent: [  ]
]

{ #category : #accessing }
ModelCreationContext >> modelFor: aCreator [

	| model |

	model := knownModels
		at: aCreator
		ifAbsent: [ ModelInContextNotFound signal: (#'Model of <1s> not found (<2p>)' expandMacrosWith: aCreator name with: aCreator) ].

	^ model
]

{ #category : #accessing }
ModelCreationContext >> modelInSequenceFor: aCreator [

	^ knownModels at: aCreator ifAbsentPut: [ aCreator modelIn: self ]
]
