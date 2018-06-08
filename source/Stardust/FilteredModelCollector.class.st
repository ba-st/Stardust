"
I'm a composite model creator, allowing to filter the models provided by the creators given to me.
"
Class {
	#name : #FilteredModelCollector,
	#superclass : #CompositeModelCreator,
	#instVars : [
		'name',
		'optionalModelCreators'
	],
	#category : #Stardust
}

{ #category : #'instance creation' }
FilteredModelCollector class >> named: aName containing: anCollectionOfModelCreators [

	self assertNotEmpty: aName.
	^ self new initializeNamed: aName containing: anCollectionOfModelCreators
]

{ #category : #disassembling }
FilteredModelCollector >> changeModelTo: aModelCollection in: aContext [

	optionalModelCreators do: [ :modelCreator | aContext changeModelFor: modelCreator to: Optional unused ].

	aModelCollection
		do: [ :aModel | 
			| selection |

			selection := Optional containing: aModel.
			optionalModelCreators detect: [ :modelCreator | modelCreator canCreate: selection ] ifFound: [ :modelCreator | aContext changeModelFor: modelCreator to: selection ] ]
]

{ #category : #enumerating }
FilteredModelCollector >> dependenciesDo: aBlock [

	^ optionalModelCreators do: aBlock
]

{ #category : #initialization }
FilteredModelCollector >> initializeNamed: aName containing: anCollectionOfModelCreators [

	name := aName.
	optionalModelCreators := anCollectionOfModelCreators
]

{ #category : #assembling }
FilteredModelCollector >> modelIn: aContext [

	| models |

	models := OrderedCollection new.
	optionalModelCreators do: [ :modelCreator | (aContext modelFor: modelCreator) withContentDo: [ :model | models add: model ] ].
	^ models
]

{ #category : #accessing }
FilteredModelCollector >> name [

	^ name
]
