"
I'm a test case
"
Class {
	#name : #ModelCreatorAdapterTest,
	#superclass : #CompositeModelCreatorTest,
	#category : #'Stardust-Tests-ModelCreation'
}

{ #category : #tests }
ModelCreatorAdapterTest >> testCanCreate [

	| creator adapter |

	creator := self newContainerControllerNamed: 'text'.
	adapter := ModelCreatorAdapter adaptingModelOf: creator using: [ :text | text asUppercase ].

	self
		assert: (adapter canCreate: '');
		assert: (adapter canCreate: 1);
		assert: (adapter canCreate: 'HI');
		assert: (adapter canCreate: self);
		assert: (adapter canCreate: adapter)
]

{ #category : #tests }
ModelCreatorAdapterTest >> testChangeModelToHasNoEffects [

	| creator adapter |

	creator := self newContainerControllerNamed: 'text'.
	adapter := ModelCreatorAdapter adaptingModelOf: creator using: [ :text | text asUppercase ].
	creator updateModelInViewsConsidering: 'some lowercase input'.
	adapter updateModelInViewsConsidering: 'A NEW TEXT'.
	
	self assertModelAssembledBy: adapter equals: 'SOME LOWERCASE INPUT'
]

{ #category : #tests }
ModelCreatorAdapterTest >> testModelCreation [

	| creator adapter |

	creator := self newContainerControllerNamed: 'text'.
	adapter := ModelCreatorAdapter adaptingModelOf: creator using: [ :text | text asUppercase ].
	creator updateModelInViewsConsidering: 'some lowercase input'.
	self assertModelAssembledBy: adapter equals: 'SOME LOWERCASE INPUT'
]

{ #category : #tests }
ModelCreatorAdapterTest >> testName [

	| creator adapter |

	creator := self newContainerControllerNamed: 'text'.
	adapter := ModelCreatorAdapter named: 'Uppercase' adaptingModelOf: creator using: [ :text | text asUppercase ].

	self assert: adapter name equals: 'Uppercase'
]
