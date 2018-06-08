"
I'm a composite model creator. I will know another creators and combine/transform/filter the models them creates.
"
Class {
	#name : #CompositeModelCreator,
	#superclass : #ModelCreator,
	#pools : [
		'Stardust'
	],
	#category : #Stardust
}

{ #category : #enumerating }
CompositeModelCreator >> dependenciesDo: aBlock [

	"Composite model creators known another creators, so it must implement this method."

	self subclassResponsibility
]

{ #category : #notifying }
CompositeModelCreator >> notifyChangesTo: aSupervisor [

	"Composite model creators never needs to notify changes, because it can't be changed outside of the supervisor control"

	
]
