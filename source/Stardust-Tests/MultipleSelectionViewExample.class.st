Class {
	#name : #MultipleSelectionViewExample,
	#superclass : #Object,
	#instVars : [
		'availableElements',
		'chosenElements',
		'interested'
	],
	#category : 'Stardust-Tests-ViewExamples'
}

{ #category : #enumerating }
MultipleSelectionViewExample class >> implementedInterfacesDo: aBlock [

	aBlock value: MultipleSelectionView
]

{ #category : #'instance creation' }
MultipleSelectionViewExample class >> new [

	^ super new initialize
]

{ #category : #'selection protocol' }
MultipleSelectionViewExample >> allowAnyOf: anElementCollection [

	availableElements := anElementCollection.
	self
		choose: chosenElements
		matchedUsing: [ :chosenElement :availableElement | chosenElement = availableElement ]
		ifUnable: [ self clearSelection ]
]

{ #category : #'selection protocol' }
MultipleSelectionViewExample >> choose: aCollection matchedUsing: aMatchBlock ifUnable: anUnableBlock [

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
MultipleSelectionViewExample >> chooseAll [

	self setChosenElementsTo: availableElements
]

{ #category : #'selection protocol' }
MultipleSelectionViewExample >> chooseElementsAtAll: anIndexCollection [

	self setChosenElementsTo: (anIndexCollection collect: [ :index | availableElements at: index ])
]

{ #category : #accessing }
MultipleSelectionViewExample >> chosenIndexes [

	^ chosenElements collect: [ :chosenElement | availableElements indexOf: chosenElement ]
]

{ #category : #api }
MultipleSelectionViewExample >> clearSelection [

	self setChosenElementsTo: #()
]

{ #category : #accessing }
MultipleSelectionViewExample >> currentSelection [

	^ chosenElements
]

{ #category : #'selection protocol' }
MultipleSelectionViewExample >> disallowAll [

	availableElements := #().
	chosenElements := #()
]

{ #category : #initialization }
MultipleSelectionViewExample >> initialize [

	super initialize.
	interested := Set new.
	self disallowAll
]

{ #category : #notifying }
MultipleSelectionViewExample >> notifyChangesTo: aSupervisor [

	interested add: aSupervisor
]

{ #category : #'selection protocol' }
MultipleSelectionViewExample >> setChosenElementsTo: aCollection [

	chosenElements := aCollection
]
