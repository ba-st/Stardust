initialization
initializeSupervising: aCreator showingErrorsAccordingTo: anErrorDisplayStrategy

	self initialize.
	context := ModelCreationContext new.
	creatorsByView := Dictionary new.
	creationSequence := ModelCreationSequence startingAt: aCreator notifyingChangesTo: self handlingErrorsAccordingTo: anErrorDisplayStrategy