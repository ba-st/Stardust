"
I'm a composite model creator. I'm responsible for creating a collection containing the models provided by the creators given to me.
"
Class {
	#name : #ModelCollector,
	#superclass : #CompositeModelCreator,
	#instVars : [
		'modelCreators',
		'name'
	],
	#category : #Stardust
}

{ #category : #'instance creation' }
ModelCollector class >> named: aName containing: anCollectionOfModelCreators [

	self assertNotEmpty: aName.
	^ self new initializeNamed: aName containing: anCollectionOfModelCreators
]

{ #category : #testing }
ModelCollector >> canCreate: anObject [

	^ anObject isCollection and: [ anObject size = modelCreators size and: [ self eachModelCreatorCanCreateTheObjectsIn: anObject ] ]
]

{ #category : #disassembling }
ModelCollector >> changeModelTo: aModelCollection in: aContext [

	modelCreators with: aModelCollection do: [ :modelCreator :model | aContext changeModelFor: modelCreator to: model ]
]

{ #category : #enumerating }
ModelCollector >> dependenciesDo: aBlock [

	^ modelCreators do: aBlock
]

{ #category : #private }
ModelCollector >> eachModelCreatorCanCreateTheObjectsIn: aCollection [

	modelCreators
		with: aCollection
		do: [ :childCreator :model | 
			(childCreator canCreate: model)
				ifFalse: [ ^ false ] ].
	^ true
]

{ #category : #initialization }
ModelCollector >> initializeNamed: aName containing: anCollectionOfModelCreators [

	name := aName.
	modelCreators := anCollectionOfModelCreators
]

{ #category : #assembling }
ModelCollector >> modelIn: aContext [

	^ modelCreators collect: [ :modelCreator | aContext modelFor: modelCreator ]
]

{ #category : #accessing }
ModelCollector >> name [

	^ name
]
