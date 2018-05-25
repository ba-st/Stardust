Class {
	#name : #ContainerView,
	#superclass : #Interface,
	#category : #'Stardust-Views'
}

{ #category : #accessing }
ContainerView class >> description [

	^ 'Visual component for user text input'
]

{ #category : #enumerating }
ContainerView class >> parentsDo: aMonadycBlock [

	
]

{ #category : #accessing }
ContainerView >> changeContentsTo: aText [

	self interfaceImplementorResponsibility
]

{ #category : #accessing }
ContainerView >> contents [

	self interfaceImplementorResponsibility
]

{ #category : #notifying }
ContainerView >> notifyChangesTo: aSupervisor [

	self interfaceImplementorResponsibility
]
