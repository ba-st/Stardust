Class {
	#name : #ModelPickingPolicy,
	#superclass : #Object,
	#category : #'Stardust-ModelCreation'
}

{ #category : #testing }
ModelPickingPolicy >> is: aSelectableObject equalTo: aModel [

	self subclassResponsibility
]

{ #category : #'selection protocol' }
ModelPickingPolicy >> pickFrom: aSelectableObject [

	self subclassResponsibility
]
