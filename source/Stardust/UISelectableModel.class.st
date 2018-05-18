Class {
	#name : #UISelectableModel,
	#superclass : #Object,
	#instVars : [
		'representedObject',
		'description'
	],
	#category : #'Stardust-ModelCreator'
}

{ #category : #'instance creation' }
UISelectableModel class >> representing: anObjectToRepresent with: aDescription [

	^ self new initializeRepresenting: anObjectToRepresent with: aDescription
]

{ #category : #comparing }
UISelectableModel >> < aUISelectableModel [

	^ self description < aUISelectableModel description
]

{ #category : #comparing }
UISelectableModel >> <= aUISelectableModel [

	^ (aUISelectableModel < self) not
]

{ #category : #comparing }
UISelectableModel >> = anObject [

	^ self == anObject or: [ self class = anObject class and: [ self description = anObject description ] ]
]

{ #category : #comparing }
UISelectableModel >> > aUISelectableModel [

	^ aUISelectableModel < self
]

{ #category : #comparing }
UISelectableModel >> >= aUISelectableModel [

	^ (self < aUISelectableModel) not
]

{ #category : #comparing }
UISelectableModel >> between: min and: max [

	^ min <= self and: [ self <= max ]
]

{ #category : #accessing }
UISelectableModel >> description [

	^ description
]

{ #category : #comparing }
UISelectableModel >> hash [

	^ self description hash
]

{ #category : #initialization }
UISelectableModel >> initializeRepresenting: anObjectToRepresent with: aDescription [

	representedObject := anObjectToRepresent.
	description := aDescription
]

{ #category : #accessing }
UISelectableModel >> max: aUISelectableModel [

	^ self < aUISelectableModel
		ifTrue: [ aUISelectableModel ]
		ifFalse: [ self ]
]

{ #category : #accessing }
UISelectableModel >> min: aUISelectableModel [

	^ self < aUISelectableModel
		ifTrue: [ self ]
		ifFalse: [ aUISelectableModel ]
]

{ #category : #printing }
UISelectableModel >> printOn: aStream [

	aStream print: description
]

{ #category : #accessing }
UISelectableModel >> representedObject [

	^ representedObject
]
