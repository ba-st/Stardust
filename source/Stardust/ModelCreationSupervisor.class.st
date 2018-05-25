Class {
	#name : #ModelCreationSupervisor,
	#superclass : #Object,
	#instVars : [
		'context',
		'creatorsByView',
		'creationSequence'
	],
	#category : #'Stardust-ModelCreator'
}

{ #category : #defaults }
ModelCreationSupervisor class >> defaultErrorDisplay [

	^ SupervisorStrategy displayingSingleError
]

{ #category : #'instance creation' }
ModelCreationSupervisor class >> supervising: aCreator [

	^ self supervising: aCreator showingErrorsAccordingTo: self defaultErrorDisplay
]

{ #category : #'instance creation' }
ModelCreationSupervisor class >> supervising: aCreator showingErrorsAccordingTo: anErrorDisplayStrategy [

	^ self new
		initializeSupervising: aCreator
		showingErrorsAccordingTo: anErrorDisplayStrategy
]

{ #category : #asserting }
ModelCreationSupervisor >> assert: aView canBeRelatedTo: aCreator [

	creatorsByView
		at: aView
		ifPresent: [ :existingCreator | 
			ProgrammingError
				signal:
					('Can''t select <1s> with <2s> because <3s> was already registered'
						expandMacrosWith: aCreator asString
						with: aView asString
						with: existingCreator asString) ]
]

{ #category : #testing }
ModelCreationSupervisor >> canCreate: aModel [

	^ creationSequence canCreate: aModel
]

{ #category : #accessing }
ModelCreationSupervisor >> changeModelTo: aModel [

	creationSequence changeModelTo: aModel in: context
]

{ #category : #changing }
ModelCreationSupervisor >> changeNotifiedBy: aView [

	| relatedCreator affectedCreators |

	relatedCreator := self creatorRelatedTo: aView.
	affectedCreators := creationSequence creatorsAffectedByChangeIn: relatedCreator.
	affectedCreators do: [ :creator | context invalidateModelFor: creator ]
]

{ #category : #accessing }
ModelCreationSupervisor >> creatorRelatedTo: aView [

	^ creatorsByView
		at: aView
		ifAbsent: [ ObjectNotFound
				signal: #'A model creation supervisor recieved a change notification from a unknow view' ]
]

{ #category : #initialization }
ModelCreationSupervisor >> initializeSupervising: aCreator showingErrorsAccordingTo: anErrorDisplayStrategy [

	self initialize.
	context := ModelCreationContext new.
	creatorsByView := Dictionary new.
	creationSequence := ModelCreationSequence
		startingAt: aCreator
		notifyingChangesTo: self
		handlingErrorsAccordingTo: anErrorDisplayStrategy
]

{ #category : #accessing }
ModelCreationSupervisor >> model [

	^ creationSequence modelIn: context
]

{ #category : #accessing }
ModelCreationSupervisor >> modelIfUnable: aBlock [

	^ [ self model ]
		on: ModelCreationFailed
		do: [ :signal | signal return: aBlock value ]
]

{ #category : #changing }
ModelCreationSupervisor >> relateChangesIn: aView withModelFor: aCreator [

	self assert: aView canBeRelatedTo: aCreator.

	creatorsByView
		at: aView
		ifAbsentPut: [ aView notifyChangesTo: self.
			aCreator ]
]

{ #category : #accessing }
ModelCreationSupervisor >> withModelDo: aMonadycBlock ifUnable: aModelCreationFailedBlock [

	| model modelCreated |

	modelCreated := [ model := self model.
	true ]
		on: ModelCreationFailed
		do: [ :signal | signal return: false ].
	^ modelCreated
		ifTrue: [ aMonadycBlock value: model ]
		ifFalse: aModelCreationFailedBlock
]
