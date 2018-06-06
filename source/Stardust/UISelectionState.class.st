Class {
	#name : #UISelectionState,
	#superclass : #Object,
	#category : #'Stardust-ModelCreation'
}

{ #category : #testing }
UISelectionState >> isSomethingSelected [

	^ self subclassResponsibility
]

{ #category : #enumerating }
UISelectionState >> withSelectionDo: aMonadycBlock [

	self subclassResponsibility
]
