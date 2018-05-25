Class {
	#name : #TextInputViewExample,
	#superclass : #Object,
	#instVars : [
		'contents',
		'interested'
	],
	#category : 'Stardust-Tests-ViewExamples'
}

{ #category : #enumerating }
TextInputViewExample class >> implementedInterfacesDo: aBlock [

	aBlock value: ContainerView
]

{ #category : #'instance creation' }
TextInputViewExample class >> new [

	^ super new initialize
]

{ #category : #accessing }
TextInputViewExample >> changeContentsTo: aText [

	contents := aText.
	self notifyInterested
]

{ #category : #accessing }
TextInputViewExample >> contents [

	^ contents
]

{ #category : #initialization }
TextInputViewExample >> initialize [

	super initialize.
	interested := Set new.
	self changeContentsTo: String new
]

{ #category : #notifying }
TextInputViewExample >> notifyChangesTo: aSupervisor [

	interested add: aSupervisor
]

{ #category : #notifying }
TextInputViewExample >> notifyInterested [

	interested do: [ :anInterested | anInterested changeNotifiedBy: self ]
]
