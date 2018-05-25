Class {
	#name : #PickUIRepresentationPolicy,
	#superclass : #ModelPickingPolicy,
	#category : #'Stardust-ModelCreator'
}

{ #category : #testing }
PickUIRepresentationPolicy >> is: aSelectableObject equalTo: aModel [

	^ aSelectableObject representedObject = aModel
]

{ #category : #'selection protocol' }
PickUIRepresentationPolicy >> pickFrom: aSelectableObject [

	^ aSelectableObject representedObject
]
