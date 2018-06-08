"
I'm something simulating a multiple selection view
"
Class {
	#name : #DummyMultipleSelectionView,
	#superclass : #Object,
	#instVars : [
		'availableElements',
		'chosenElements',
		'interested'
	],
	#category : #'Stardust-Tests-Support'
}

{ #category : #'instance creation' }
DummyMultipleSelectionView class >> new [

	^ super new initialize
]

{ #category : #'selection protocol' }
DummyMultipleSelectionView >> allowAnyOf: anElementCollection [

	availableElements := anElementCollection.
	self
		choose: chosenElements
		matchedUsing: [ :chosenElement :availableElement | chosenElement = availableElement ]
		ifUnable: [ self clearSelection ]
]

{ #category : #'selection protocol' }
DummyMultipleSelectionView >> allowsAnySatisfying: aPredicate [

	^ availableElements anySatisfy: aPredicate
]

{ #category : #'selection protocol' }
DummyMultipleSelectionView >> choose: aCollection matchedUsing: aMatchBlock ifUnable: anUnableBlock [

	| matches |

	matches := OrderedCollection new.
	aCollection
		do: [ :elementToMatch | 
			availableElements
				detect: [ :availableElement | aMatchBlock value: elementToMatch value: availableElement ]
				ifFound: [ :matchingElement | matches add: matchingElement ]
				ifNone: [ ^ anUnableBlock value ] ].
	self setChosenElementsTo: matches asArray
]

{ #category : #'selection protocol' }
DummyMultipleSelectionView >> chooseAll [

	self setChosenElementsTo: availableElements
]

{ #category : #'selection protocol' }
DummyMultipleSelectionView >> chooseElementsAtAll: anIndexCollection [

	self setChosenElementsTo: (anIndexCollection collect: [ :index | availableElements at: index ])
]

{ #category : #accessing }
DummyMultipleSelectionView >> chosenIndexes [

	^ chosenElements collect: [ :chosenElement | availableElements indexOf: chosenElement ]
]

{ #category : #api }
DummyMultipleSelectionView >> clearSelection [

	self setChosenElementsTo: #()
]

{ #category : #accessing }
DummyMultipleSelectionView >> currentSelection [

	^ chosenElements
]

{ #category : #'selection protocol' }
DummyMultipleSelectionView >> disallowAll [

	availableElements := #().
	chosenElements := #()
]

{ #category : #initialization }
DummyMultipleSelectionView >> initialize [

	super initialize.
	interested := Set new.
	self disallowAll
]

{ #category : #notifying }
DummyMultipleSelectionView >> notifyChangesTo: aSupervisor [

	interested add: aSupervisor
]

{ #category : #'selection protocol' }
DummyMultipleSelectionView >> setChosenElementsTo: aCollection [

	chosenElements := aCollection
]
