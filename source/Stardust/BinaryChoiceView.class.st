Class {
	#name : #BinaryChoiceView,
	#superclass : #Interface,
	#category : #'Stardust-Views'
}

{ #category : #accessing }
BinaryChoiceView class >> description [

	^ 'Visual component to toggle between two values'
]

{ #category : #enumerating }
BinaryChoiceView class >> parentsDo: aMonadycBlock [

	
]

{ #category : #testing }
BinaryChoiceView >> allows: aModel [

	self interfaceImplementorResponsibility
]

{ #category : #accessing }
BinaryChoiceView >> currentSelection [

	self interfaceImplementorResponsibility
]

{ #category : #notifying }
BinaryChoiceView >> notifyChangesTo: aSupervisor [

	self interfaceImplementorResponsibility
]

{ #category : #'selection protocol' }
BinaryChoiceView >> toggleCurrentSelection [

	self interfaceImplementorResponsibility
]
