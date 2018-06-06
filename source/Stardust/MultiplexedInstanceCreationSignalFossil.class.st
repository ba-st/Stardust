Class {
	#name : #MultiplexedInstanceCreationSignalFossil,
	#superclass : #Object,
	#instVars : [
		'userAwareDescription'
	],
	#category : #'Stardust-ModelCreation'
}

{ #category : #'instance creation' }
MultiplexedInstanceCreationSignalFossil class >> with: errorDescription [

	^ self new initializeWith: errorDescription
]

{ #category : #initialization }
MultiplexedInstanceCreationSignalFossil >> initializeWith: errorDescription [

	userAwareDescription := errorDescription
]

{ #category : #accessing }
MultiplexedInstanceCreationSignalFossil >> messageText [

	^ self userAwareDescription
]

{ #category : #handling }
MultiplexedInstanceCreationSignalFossil >> return [

	
]

{ #category : #accessing }
MultiplexedInstanceCreationSignalFossil >> userAwareDescription [

	^ userAwareDescription
]
