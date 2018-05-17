accessing
modelFor: aCreator

	| model |

	model := knownModels
		at: aCreator
		ifAbsent: [ ModelInContextNotFound signal: (#'Model of <1s> not found (<2p>)' expandMacrosWith: aCreator name with: aCreator) ].

	^ model