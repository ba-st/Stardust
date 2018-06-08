"
I'm an abstract test case
"
Class {
	#name : #ModelCreatorTest,
	#superclass : #TestCase,
	#instVars : [
		'context'
	],
	#category : #'Stardust-Tests-ModelCreation'
}

{ #category : #testing }
ModelCreatorTest class >> isAbstract [

	^ self name = #ModelCreatorTest
]

{ #category : #'private - asserting' }
ModelCreatorTest >> assertModelAssembledBy: aCreator equals: anExpectedModel [

	self assert: (self supervisorFor: aCreator) model equals: anExpectedModel
]

{ #category : #'private - asserting' }
ModelCreatorTest >> assertModelCreationFailedFor: aCreator [

	self should: [ (self supervisorFor: aCreator) model ] raise: ModelCreationFailed
]

{ #category : #'widget - support' }
ModelCreatorTest >> multipleSelectionView [

	^ DummyMultipleSelectionView new
]

{ #category : #'widget - support' }
ModelCreatorTest >> newSingleSelectionView [

	^ DummySingleSelectionView new
]

{ #category : #running }
ModelCreatorTest >> setUp [

	super setUp.
	context := ModelCreationContext new
]

{ #category : #'private - building' }
ModelCreatorTest >> supervisorFor: aCreator [

	^ ModelCreationSupervisor supervising: aCreator
]

{ #category : #'widget - support' }
ModelCreatorTest >> textField [

	^ DummyTextInput new
]
