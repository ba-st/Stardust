Extension { #name : #TestAsserter }

{ #category : #'*Stardust-Tests-ModelCreator' }
TestAsserter >> should: aBlock raise: anException withDescription: aDescription [

	self
		should: aBlock
		raise: anException
		whoseDescriptionIncludes: aDescription
		description: ('Exception message should be: <1s>' expandMacrosWith: aDescription)
]
