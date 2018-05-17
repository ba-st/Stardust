changing
relateChangesIn: aView withModelFor: aCreator

	self assert: aView canBeRelatedTo: aCreator.

	creatorsByView
		at: aView
		ifAbsentPut: [ aView notifyChangesTo: self.
			aCreator ]