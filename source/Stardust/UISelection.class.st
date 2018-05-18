Class {
	#name : #UISelection,
	#superclass : #UISelectionState,
	#instVars : [
		'selection'
	],
	#category : 'Stardust-ModelCreator'
}

{ #category : #'instance creation' }
UISelection class >> is: anObject [

	^ self new initializeIs: anObject
]

{ #category : #comparing }
UISelection >> = anObject [

	^ self == anObject or: [ (self isAn: anObject class) and: [ selection = anObject selection ] ]
]

{ #category : #comparing }
UISelection >> hash [

	^ selection hash
]

{ #category : #initialization }
UISelection >> initializeIs: anObject [

	selection := anObject
]

{ #category : #testing }
UISelection >> isSomethingSelected [

	^ true
]

{ #category : #accessing }
UISelection >> selection [

	^ selection
]

{ #category : #enumerating }
UISelection >> withSelectionDo: aMonadycBlock [

	aMonadycBlock value: selection
]
