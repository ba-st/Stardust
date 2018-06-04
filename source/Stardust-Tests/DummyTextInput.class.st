Class {
	#name : #DummyTextInput,
	#superclass : #Object,
	#instVars : [
		'contents',
		'interested'
	],
	#category : #'Stardust-Tests-ViewExamples'
}

{ #category : #'instance creation' }
DummyTextInput class >> new [

	^ super new initialize
]

{ #category : #accessing }
DummyTextInput >> changeContentsTo: aText [

	contents := aText.
	self notifyInterested
]

{ #category : #accessing }
DummyTextInput >> contents [

	^ contents
]

{ #category : #initialization }
DummyTextInput >> initialize [

	super initialize.
	interested := Set new.
	self changeContentsTo: String new
]

{ #category : #notifying }
DummyTextInput >> notifyChangesTo: aSupervisor [

	interested add: aSupervisor
]

{ #category : #notifying }
DummyTextInput >> notifyInterested [

	interested do: [ :anInterested | anInterested changeNotifiedBy: self ]
]
