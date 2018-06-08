"
I'm an abstract test case
"
Class {
	#name : #CompositeModelCreatorTest,
	#superclass : #ModelCreatorTest,
	#category : #'Stardust-Tests-ModelCreation'
}

{ #category : #testing }
CompositeModelCreatorTest class >> isAbstract [

	^ self name = #CompositeModelCreatorTest
]

{ #category : #'private - building' }
CompositeModelCreatorTest >> newContainerControllerNamed: aName [

	^ ContainerController named: aName controlling: self textField
]

{ #category : #'private - building' }
CompositeModelCreatorTest >> newFixedCreatorFor: aModel [

	^ FixedModelCreator creating: aModel
]

{ #category : #'private - building' }
CompositeModelCreatorTest >> newSingleModelPickerNamed: aName [

	^ SingleModelPicker named: aName pickingFrom: self newSingleSelectionView
]
