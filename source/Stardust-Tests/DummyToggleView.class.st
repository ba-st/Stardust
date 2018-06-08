"
I'm something simulating a toggle view
"
Class {
	#name : #DummyToggleView,
	#superclass : #Object,
	#instVars : [
		'interested',
		'validModels'
	],
	#category : #'Stardust-Tests-Support'
}

{ #category : #'instance creation' }
DummyToggleView class >> onModel: anOnModel offModel: anOffModel [

	^self new initializeOnModel: anOnModel offModel: anOffModel
]

{ #category : #'selection protocol' }
DummyToggleView >> allows: anObject [

	^ validModels includes: anObject
]

{ #category : #'selection protocol' }
DummyToggleView >> currentSelection [

	^ validModels current
]

{ #category : #initialization }
DummyToggleView >> initializeOnModel: anOnModel offModel: anOffModel [

	validModels := CircularIterator cyclingOver: {anOffModel. anOnModel}.
	interested := Set new
]

{ #category : #notifying }
DummyToggleView >> notifyChangesTo: aSupervisor [

	interested add: aSupervisor
]

{ #category : #notifying }
DummyToggleView >> notifyInterested [

	interested do: [ :anInterested | anInterested changeNotifiedBy: self ]
]

{ #category : #'selection protocol' }
DummyToggleView >> toggleCurrentSelection [

	validModels next.
	self notifyInterested
]
