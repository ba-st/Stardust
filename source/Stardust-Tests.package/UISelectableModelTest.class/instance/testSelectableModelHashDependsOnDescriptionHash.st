tests
testSelectableModelHashDependsOnDescriptionHash

	| originalModel equivalentModel differentModel |

	originalModel := UISelectableModel representing: 4 with: 'Un número'.
	equivalentModel := UISelectableModel representing: 5 with: 'Un número'.
	differentModel := UISelectableModel representing: 7 with: 'Does Not Matter'.
	self
		assert: originalModel equals: originalModel;
		assert: equivalentModel equals: equivalentModel;
		assert: differentModel equals: differentModel.
	self
		assert: originalModel hash equals: equivalentModel hash;
		assert: equivalentModel hash equals: originalModel hash;
		deny: originalModel hash = differentModel hash;
		deny: differentModel hash = originalModel hash;
		deny: equivalentModel hash = differentModel hash;
		deny: differentModel hash = equivalentModel hash