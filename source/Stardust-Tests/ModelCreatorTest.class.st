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

{ #category : #'widget - support' }
ModelCreatorTest >> multipleSelectionView [

	^ DummyMultipleSelectionView new
]

{ #category : #running }
ModelCreatorTest >> setUp [

	super setUp.
	context := ModelCreationContext new
]

{ #category : #'widget - support' }
ModelCreatorTest >> singleSelectionView [

	^ DummySingleSelectionView new
]

{ #category : #'widget - support' }
ModelCreatorTest >> textField [

	^ DummyTextInput new
]
