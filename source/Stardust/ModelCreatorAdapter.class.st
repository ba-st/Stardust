"
I'm an adapter for model creators. I can convert the model created by other creator using a block provided to me. 
Use me with care. I can't disassemble a model and propagate the changes to my child. And will say that I can create anything.
"
Class {
	#name : #ModelCreatorAdapter,
	#superclass : #CompositeModelCreator,
	#instVars : [
		'creator',
		'adaptingBlock',
		'name'
	],
	#category : #Stardust
}

{ #category : #'instance creation' }
ModelCreatorAdapter class >> adaptingModelOf: aCreator using: aBlock [

	^ self named: aCreator name adaptingModelOf: aCreator using: aBlock
]

{ #category : #'instance creation' }
ModelCreatorAdapter class >> named: aName adaptingModelOf: aCreator using: aBlock [

	^ self new initializeNamed: aName adapting: aCreator with: aBlock
]

{ #category : #testing }
ModelCreatorAdapter >> canCreate: aModel [

	^ true
]

{ #category : #disassembling }
ModelCreatorAdapter >> changeModelTo: aModel in: aContext [
]

{ #category : #accessing }
ModelCreatorAdapter >> dependenciesDo: aBlock [

	^ aBlock value: creator
]

{ #category : #initialization }
ModelCreatorAdapter >> initializeNamed: aName adapting: aCreator with: aBlock [

	name := aName.
	creator := aCreator.
	adaptingBlock := aBlock
]

{ #category : #assembling }
ModelCreatorAdapter >> modelIn: aContext [

	^ adaptingBlock value: (aContext modelFor: creator)
]

{ #category : #accessing }
ModelCreatorAdapter >> name [

	^ name
]
