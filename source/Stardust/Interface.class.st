Class {
	#name : #Interface,
	#superclass : #Object,
	#category : 'Stardust-Views'
}

{ #category : #accessing }
Interface class >> description [

	self subclassResponsibility
]

{ #category : #enumerating }
Interface class >> parentsDo: aBlock [

	self subclassResponsibility
]

{ #category : #signaling }
Interface >> interfaceImplementorResponsibility [

	self shouldBeImplemented
]
