Class {
	#name : #UISelectableModelTest,
	#superclass : #TestCase,
	#category : #'Stardust-Tests-ModelCreation'
}

{ #category : #tests }
UISelectableModelTest >> testRepresentedObjectCanBeObtained [

	| item |

	item := UISelectableModel representing: self with: 'El Test'.
	self
		assert: item representedObject equals: self;
		assert: item description equals: 'El Test'
]

{ #category : #tests }
UISelectableModelTest >> testSelectableModelEqualityDependsOnDescription [

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
]

{ #category : #tests }
UISelectableModelTest >> testSelectableModelHashDependsOnDescriptionHash [

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
]
