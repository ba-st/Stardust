"
I'm an abstract class representing a Model Creator. A model creator is responsible of assembling/dissasembling a model. Most of my subclasses will interact with some UI component driving the user interaction. The other ones are for composing, transforming and filtering complex models. 
"
Class {
	#name : #ModelCreator,
	#superclass : #Object,
	#pools : [
		'Stardust'
	],
	#category : #Stardust
}

{ #category : #'private - preconditions' }
ModelCreator class >> assert: aView implements: anInterface [

	AssertionChecker enforce: [ anInterface isImplementedBy: aView ] because: 'The provided view is not implementing the required API'
]

{ #category : #'private - preconditions' }
ModelCreator class >> assertNotEmpty: aName [

	AssertionChecker enforce: [ aName trimBoth notEmpty ] because: 'A model creator must have a name.' raising: InstanceCreationFailed
]

{ #category : #disassembling }
ModelCreator >> changeModelTo: aModel in: aContext [

	self subclassResponsibility
]

{ #category : #enumerating }
ModelCreator >> dependenciesDo: aBlock [

	
]

{ #category : #assembling }
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

{ #category : #disassembling }
ModelCreator >> updateModelInViewsConsidering: aModel [

	(ModelCreationSupervisor supervising: self) changeModelTo: aModel
]
