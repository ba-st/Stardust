Class {
	#name : #MultipleSelectionView,
	#superclass : #Interface,
	#category : 'Stardust-Views'
}

{ #category : #accessing }
MultipleSelectionView class >> description [

	^ 'Multiple selection visual component'
]

{ #category : #enumerating }
MultipleSelectionView class >> parentsDo: aMonadycBlock [

	
]

{ #category : #'as yet unclassified' }
MultipleSelectionView >> allowAnyOf: anElementCollection [

	self interfaceImplementorResponsibility
]

{ #category : #'as yet unclassified' }
MultipleSelectionView >> allowAnySatisfying: aMatchBlock [

	self interfaceImplementorResponsibility
]

{ #category : #'as yet unclassified' }
MultipleSelectionView >> choose: aCollection matchedUsing: aMatchBlock ifUnable: anUnableBlock [

	self interfaceImplementorResponsibility
]

{ #category : #'as yet unclassified' }
MultipleSelectionView >> chooseAll [

	self interfaceImplementorResponsibility
]

{ #category : #accessing }
MultipleSelectionView >> currentSelection [

	self interfaceImplementorResponsibility
]

{ #category : #'as yet unclassified' }
MultipleSelectionView >> disallowAll [

	self interfaceImplementorResponsibility
]

{ #category : #notifying }
MultipleSelectionView >> notifyChangesTo: aSupervisor [

	self interfaceImplementorResponsibility
]
