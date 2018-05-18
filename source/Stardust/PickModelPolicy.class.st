Class {
	#name : #PickModelPolicy,
	#superclass : #ModelPickingPolicy,
	#category : 'Stardust-ModelCreator'
}

{ #category : #testing }
PickModelPolicy >> is: aSelectableObject equalTo: aModel [

	^ aSelectableObject = aModel
]

{ #category : #'selection protocol' }
PickModelPolicy >> pickFrom: aModel [

	^ aModel
]
