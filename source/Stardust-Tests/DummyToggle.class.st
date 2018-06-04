Class {
	#name : #DummyToggle,
	#superclass : #Object,
	#instVars : [
		'interested'
	],
	#category : #'Stardust-Tests-ViewExamples'
}

{ #category : #'instance creation' }
DummyToggle class >> new [

	^ super new initialize
]

{ #category : #initialization }
DummyToggle >> initialize [

	super initialize.
	interested := Set new
]

{ #category : #notifying }
DummyToggle >> notifyChangesTo: aSupervisor [

	interested add: aSupervisor
]

{ #category : #notifying }
DummyToggle >> notifyInterested [

	interested do: [ :anInterested | anInterested changeNotifiedBy: self ]
]

{ #category : #'selection protocol' }
DummyToggle >> toggleCurrentSelection [

	self notifyInterested
]
