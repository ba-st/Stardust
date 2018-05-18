Class {
	#name : #FilteredModelCollector,
	#superclass : #ModelCreator,
	#instVars : [
		'name',
		'optionalModelCreators'
	],
	#category : 'Stardust-ModelCreator'
}

{ #category : #'instance creation' }
FilteredModelCollector class >> named: aName containing: anCollectionOfModelCreators [

	self assertNotEmpty: aName.
	^ self new initializeNamed: aName containing: anCollectionOfModelCreators
]

{ #category : #accessing }
FilteredModelCollector >> changeModelTo: aModelCollection in: aContext [

	optionalModelCreators do: [ :modelCreator | aContext changeModelFor: modelCreator to: UINullSelection new ].

	aModelCollection
		do: [ :aModel | 
			| selection |

			selection := UISelection is: aModel.
			optionalModelCreators
				detect: [ :modelCreator | modelCreator canCreate: selection ]
				ifFound: [ :modelCreator | aContext changeModelFor: modelCreator to: selection ] ]
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

{ #category : #accessing }
FilteredModelCollector >> modelIn: aContext [

	| models |

	models := OrderedCollection new.
	optionalModelCreators do: [ :modelCreator | (aContext modelFor: modelCreator) withSelectionDo: [ :model | models add: model ] ].
	^ models
]

{ #category : #accessing }
FilteredModelCollector >> name [

	^ name
]

{ #category : #notifying }
FilteredModelCollector >> notifyChangesTo: aSupervisor [

	
]
