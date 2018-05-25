Class {
	#name : #MultiplexedInstanceCreationSignalFossil,
	#superclass : #Object,
	#instVars : [
		'userAwareDescription'
	],
	#category : #'Stardust-ModelCreator'
}

{ #category : #'instance creation' }
MultiplexedInstanceCreationSignalFossil class >> with: errorDescription [

	^ self new initializeWith: errorDescription
]

{ #category : #initialization }
MultiplexedInstanceCreationSignalFossil >> initializeWith: errorDescription [

	userAwareDescription := errorDescription
]

{ #category : #handling }
MultiplexedInstanceCreationSignalFossil >> return [

	
]

{ #category : #accessing }
MultiplexedInstanceCreationSignalFossil >> userAwareDescription [

	^ userAwareDescription
]
