"
I'm something simulating a single selection view
"
Class {
	#name : #DummySingleSelectionView,
	#superclass : #Object,
	#instVars : [
		'availableElements',
		'chosenElement',
		'interested'
	],
	#category : #'Stardust-Tests-Support'
}

{ #category : #'instance creation' }
DummySingleSelectionView class >> new [

	^ super new initialize
]

{ #category : #'selection protocol' }
DummySingleSelectionView >> allowAnyOf: anElementCollection [

	availableElements := anElementCollection.
	chosenElement
		withContentDo: [ :selection | self chooseAnySatisfying: [ :element | selection = element ] ifNone: [ self invalidateSelection ] ]
		ifUnused: [ self invalidateSelection ]
]

{ #category : #'selection protocol' }
DummySingleSelectionView >> allowsAnySatisfying: aPredicate [

	^ availableElements anySatisfy: aPredicate
]

{ #category : #'selection protocol' }
DummySingleSelectionView >> chooseAnySatisfying: aMatchBlock ifNone: aBlock [

	availableElements detect: aMatchBlock ifFound: [ :found | self setChosenElementTo: (Optional containing: found) ] ifNone: aBlock
]

{ #category : #accessing }
DummySingleSelectionView >> chooseElementAt: anIndex [

	self setChosenElementTo: (Optional containing: (availableElements at: anIndex))
]

{ #category : #'private-accessing' }
DummySingleSelectionView >> chosenIndex [

	^ chosenElement withContentDo: [ :selection | availableElements indexOf: selection ] ifUnused: [ 0	"Same behavior as SequentiableCollection" ]
]

{ #category : #accessing }
DummySingleSelectionView >> currentSelectionIfNone: aBlock [

	^ chosenElement withContentDo: [ :element | element ] ifUnused: aBlock
]

{ #category : #'selection protocol' }
DummySingleSelectionView >> disallowAll [

	availableElements := #().
	self invalidateSelection
]

{ #category : #initialization }
DummySingleSelectionView >> initialize [

	super initialize.
	interested := Set new.
	self disallowAll
]

{ #category : #'private-accessing' }
DummySingleSelectionView >> invalidSelection [

	^ Optional unusedBecause: 'No element selected'
]

{ #category : #'selection protocol' }
DummySingleSelectionView >> invalidateSelection [

	self setChosenElementTo: self invalidSelection
]

{ #category : #notifying }
DummySingleSelectionView >> notifyChangesTo: aSupervisor [

	interested add: aSupervisor
]

{ #category : #notifying }
DummySingleSelectionView >> notifyInterested [

	interested do: [ :anInterested | anInterested changeNotifiedBy: self ]
]

{ #category : #initialization }
DummySingleSelectionView >> setChosenElementTo: anElement [

	chosenElement := anElement.
	self notifyInterested
]
