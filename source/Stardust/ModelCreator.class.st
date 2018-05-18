Class {
	#name : #ModelCreator,
	#superclass : #Object,
	#category : 'Stardust-ModelCreator'
}

{ #category : #preconditions }
ModelCreator class >> assertNotEmpty: aName [

	AssertionChecker enforce: [ aName trimBoth notEmpty ] because: 'A model creator must have a name' raising: InstanceCreationFailed
]

{ #category : #accessing }
ModelCreator >> changeModelTo: aModel in: aContext [

	self subclassResponsibility
]

{ #category : #enumerating }
ModelCreator >> dependenciesDo: aBlock [

	self subclassResponsibility
]

{ #category : #accessing }
ModelCreator >> modelIn: aContext [

	self subclassResponsibility
]

{ #category : #accessing }
ModelCreator >> name [

	self subclassResponsibility
]

{ #category : #notifying }
ModelCreator >> notifyChangesTo: aSupervisor [

	self subclassResponsibility
]

{ #category : #printing }
ModelCreator >> printOn: aStream [

	aStream nextPutAll: self name
]

{ #category : #utility }
ModelCreator >> updateModelInViewsConsidering: aModel [

	(ModelCreationSupervisor supervising: self) changeModelTo: aModel
]
