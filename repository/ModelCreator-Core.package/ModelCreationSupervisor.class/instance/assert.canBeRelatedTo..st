asserting
assert: aView canBeRelatedTo: aCreator

	creatorsByView
		at: aView
		ifPresent: [ :existingCreator | 
			ProgrammingError
				signal:
					('Can''t select <1s> with <2s> because <3s> was already registered'
						expandMacrosWith: aCreator asString
						with: aView asString
						with: existingCreator asString) ]