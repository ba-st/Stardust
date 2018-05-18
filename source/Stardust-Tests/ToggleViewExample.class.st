Class {
	#name : #ToggleViewExample,
	#superclass : #Object,
	#instVars : [
		'interested'
	],
	#category : 'Stardust-Tests-ViewExamples'
}

{ #category : #enumerating }
ToggleViewExample class >> implementedInterfacesDo: aBlock [

	aBlock value: BinaryChoiceView
]

{ #category : #'instance creation' }
ToggleViewExample class >> new [

	^ super new initialize
]

{ #category : #initialization }
ToggleViewExample >> initialize [

	super initialize.
	interested := Set new
]

{ #category : #notifying }
ToggleViewExample >> notifyChangesTo: aSupervisor [

	interested add: aSupervisor
]

{ #category : #notifying }
ToggleViewExample >> notifyInterested [

	interested do: [ :anInterested | anInterested changeNotifiedBy: self ]
]

{ #category : #'selection protocol' }
ToggleViewExample >> toggleCurrentSelection [

	self notifyInterested
]
