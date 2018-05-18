Class {
	#name : #SingleSelectionView,
	#superclass : #Interface,
	#category : #'Stardust-Views'
}

{ #category : #accessing }
SingleSelectionView class >> description [

	^ 'Single selection visual component'
]

{ #category : #enumerating }
SingleSelectionView class >> parentsDo: aMonadycBlock [

	
]

{ #category : #'as yet unclassified' }
SingleSelectionView >> allowAnyOf: anElementCollection [

	self interfaceImplementorResponsibility
]

{ #category : #'as yet unclassified' }
SingleSelectionView >> allowsAnySatisfying: aMatchBlock [

	self interfaceImplementorResponsibility
]

{ #category : #'as yet unclassified' }
SingleSelectionView >> chooseAnySatisfying: aMatchBlock ifNone: aBlock [

	self interfaceImplementorResponsibility
]

{ #category : #accessing }
SingleSelectionView >> currentSelectionIfNone: aBlock [

	self interfaceImplementorResponsibility
]

{ #category : #'as yet unclassified' }
SingleSelectionView >> disallowAll [

	self interfaceImplementorResponsibility
]

{ #category : #notifying }
SingleSelectionView >> notifyChangesTo: aSupervisor [

	self interfaceImplementorResponsibility
]
