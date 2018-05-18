Class {
	#name : #UINullSelection,
	#superclass : #UISelectionState,
	#category : 'Stardust-ModelCreator'
}

{ #category : #comparing }
UINullSelection >> = anObject [

	^ self class = anObject class
]

{ #category : #comparing }
UINullSelection >> hash [

	^ 3354
]

{ #category : #testing }
UINullSelection >> isSomethingSelected [

	^ false
]

{ #category : #enumerating }
UINullSelection >> withSelectionDo: aMonadycBlock [

	
]
