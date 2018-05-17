*Stardust-Tests-ModelCreator
should: aBlock raise: anException withDescription: aDescription

	self
		should: aBlock
		raise: anException
		whoseDescriptionIncludes: aDescription
		description: ('Exception message should be: <1s>' expandMacrosWith: aDescription)