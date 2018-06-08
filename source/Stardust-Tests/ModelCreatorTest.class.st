"
I'm an abstract test case
"
Class {
	#name : #ModelCreatorTest,
	#superclass : #TestCase,
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

{ #category : #'private - building' }
ModelCreatorTest >> newMultipleSelectionView [

	^ DummyMultipleSelectionView new
]

{ #category : #'private - building' }
ModelCreatorTest >> newSingleSelectionView [

	^ DummySingleSelectionView new
]

{ #category : #'private - building' }
ModelCreatorTest >> newTextField [

	^ DummyTextInput new
]

{ #category : #'private - building' }
ModelCreatorTest >> supervisorFor: aCreator [

	^ ModelCreationSupervisor supervising: aCreator
]
