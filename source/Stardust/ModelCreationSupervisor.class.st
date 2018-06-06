"
I'm a model creation supervisor and I'm responsible of coordinating the whole process of creating a top level model for a given model creator structure. 
I'm the one guy who is hooked up as the event listener on the UI components interacting with the user.
"
Class {
	#name : #ModelCreationSupervisor,
	#superclass : #Object,
	#instVars : [
		'context',
		'creatorsByView',
		'creationSequence'
	],
	#category : #'Stardust-ModelCreation'
}

{ #category : #'instance creation' }
ModelCreationSupervisor class >> supervising: aTopLevelCreator [

	^ self supervising: aTopLevelCreator showingErrorsAccordingTo: SupervisorStrategy displayingSingleError
]

{ #category : #'instance creation' }
ModelCreationSupervisor class >> supervising: aTopLevelCreator showingErrorsAccordingTo: anErrorDisplayStrategy [

	^ self new
		initializeSupervising: aTopLevelCreator
		showingErrorsAccordingTo: anErrorDisplayStrategy
]

{ #category : #private }
ModelCreationSupervisor >> assert: aView canBeRelatedTo: aCreator [

	creatorsByView
		at: aView
		ifPresent: [ :existingCreator | 
			Error
				signal:
					('Can''t relate the view (<1s>) with the creator (<2s>) because was already related to <3s>.'
						expandMacrosWith: aCreator asString
						with: aView asString
						with: existingCreator asString) ]
]

{ #category : #testing }
ModelCreationSupervisor >> canCreate: aModel [

	^ creationSequence canCreate: aModel
]

{ #category : #disassembling }
ModelCreationSupervisor >> changeModelTo: aModel [

	creationSequence changeModelTo: aModel in: context
]

{ #category : #notification }
ModelCreationSupervisor >> changeNotifiedBy: aView [

	creationSequence invalidateModelFor: (self creatorRelatedTo: aView) in: context
]

{ #category : #private }
ModelCreationSupervisor >> creatorRelatedTo: aView [

	^ creatorsByView at: aView ifAbsent: [ ObjectNotFound signal: #'A model creation supervisor recieved a change notification from a unknow view' ]
]

{ #category : #initialization }
ModelCreationSupervisor >> initializeSupervising: aTopLevelCreator showingErrorsAccordingTo: anErrorDisplayStrategy [

	self initialize.
	context := ModelCreationContext new.
	creatorsByView := Dictionary new.
	creationSequence := ModelCreationSequence
		startingAt: aTopLevelCreator
		notifyingChangesTo: self
		handlingErrorsAccordingTo: anErrorDisplayStrategy
]

{ #category : #assembling }
ModelCreationSupervisor >> model [

	^ creationSequence modelIn: context
]

{ #category : #assembling }
ModelCreationSupervisor >> modelIfUnable: aBlock [

	^ self withModelDo: [ :model | model ] ifUnable: aBlock
]

{ #category : #notification }
ModelCreationSupervisor >> relateChangesIn: aView withModelFor: aCreator [

	self assert: aView canBeRelatedTo: aCreator.

	creatorsByView
		at: aView
		ifAbsentPut: [ aView notifyChangesTo: self.
			aCreator ]
]

{ #category : #assembling }
ModelCreationSupervisor >> withModelDo: aMonadycBlock ifUnable: aModelCreationFailedBlock [

	^ [ aMonadycBlock value: self model ]
		on: ModelCreationFailed
		do: [ :error | error return: aModelCreationFailedBlock value ]
]
