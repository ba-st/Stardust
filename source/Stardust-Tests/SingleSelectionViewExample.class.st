Class {
	#name : #SingleSelectionViewExample,
	#superclass : #Object,
	#instVars : [
		'availableElements',
		'chosenElement',
		'interested'
	],
	#category : 'Stardust-Tests-ViewExamples'
}

{ #category : #enumerating }
SingleSelectionViewExample class >> implementedInterfacesDo: aBlock [

	aBlock value: SingleSelectionView
]

{ #category : #'instance creation' }
SingleSelectionViewExample class >> new [

	^ super new initialize
]

{ #category : #'selection protocol' }
SingleSelectionViewExample >> allowAnyOf: anElementCollection [

	availableElements := anElementCollection.
	chosenElement
		withContentDo: [ :selection | self chooseAnySatisfying: [ :element | selection = element ] ifNone: [ self invalidateSelection ] ]
		ifUnused: [ self invalidateSelection ]
]

{ #category : #'selection protocol' }
SingleSelectionViewExample >> chooseAnySatisfying: aMatchBlock ifNone: aBlock [

	availableElements detect: aMatchBlock ifFound: [ :found | self setChosenElementTo: (Optional containing: found) ] ifNone: aBlock
]

{ #category : #accessing }
SingleSelectionViewExample >> chooseElementAt: anIndex [

	self setChosenElementTo: (Optional containing: (availableElements at: anIndex))
]

{ #category : #'private-accessing' }
SingleSelectionViewExample >> chosenIndex [

	^ chosenElement withContentDo: [ :selection | availableElements indexOf: selection ] ifUnused: [ 0	"Same behavior as SequentiableCollection" ]
]

{ #category : #accessing }
SingleSelectionViewExample >> currentSelectionIfNone: aBlock [

	^ chosenElement withContentDo: [ :element | element ] ifUnused: aBlock
]

{ #category : #'selection protocol' }
SingleSelectionViewExample >> disallowAll [

	availableElements := #().
	self invalidateSelection
]

{ #category : #initialization }
SingleSelectionViewExample >> initialize [

	super initialize.
	interested := Set new.
	self disallowAll
]

{ #category : #'private-accessing' }
SingleSelectionViewExample >> invalidSelection [

	^ Optional unusedBecause: 'No element selected'
]

{ #category : #'selection protocol' }
SingleSelectionViewExample >> invalidateSelection [

	self setChosenElementTo: self invalidSelection
]

{ #category : #notifying }
SingleSelectionViewExample >> notifyChangesTo: aSupervisor [

	interested add: aSupervisor
]

{ #category : #notifying }
SingleSelectionViewExample >> notifyInterested [

	interested do: [ :anInterested | anInterested changeNotifiedBy: self ]
]

{ #category : #initialization }
SingleSelectionViewExample >> setChosenElementTo: anElement [

	chosenElement := anElement.
	self notifyInterested
]
