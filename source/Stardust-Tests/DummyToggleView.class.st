"
I'm something simulating a toggle view
"
Class {
	#name : #DummyToggleView,
	#superclass : #Object,
	#instVars : [
		'interested'
	],
	#category : #'Stardust-Tests-Support'
}

{ #category : #'instance creation' }
DummyToggleView class >> new [

	^ super new initialize
]

{ #category : #initialization }
DummyToggleView >> initialize [

	super initialize.
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

	self notifyInterested
]
