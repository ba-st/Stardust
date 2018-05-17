tests
testSelectableModelEqualityDependsOnDescription

	| originalModel equivalentModel differentModel |

	originalModel := UISelectableModel representing: 4 with: 'Un número'.
	equivalentModel := UISelectableModel representing: 5 with: 'Un número'.
	differentModel := UISelectableModel representing: 7 with: 'Does Not Matter'.
	self
		assert: originalModel equals: originalModel;
		assert: equivalentModel equals: equivalentModel;
		assert: differentModel equals: differentModel.
	self
		assert: originalModel equals: equivalentModel;
		assert: equivalentModel equals: originalModel;
		deny: originalModel = differentModel;
		deny: differentModel = originalModel;
		deny: equivalentModel = differentModel;
		deny: differentModel = equivalentModel