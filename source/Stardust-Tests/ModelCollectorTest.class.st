"
I'm a test case
"
Class {
	#name : #ModelCollectorTest,
	#superclass : #CompositeModelCreatorTest,
	#category : #'Stardust-Tests-ModelCreation'
}

{ #category : #tests }
ModelCollectorTest >> testCanCreate [

	| creator |

	creator := ModelCollector named: 'Numbers' containing: (Array with: (self newFixedCreatorFor: 1) with: (self newFixedCreatorFor: 2)).

	self
		assert: (creator canCreate: #(1 2));
		deny: (creator canCreate: #(2 1));
		deny: (creator canCreate: #());
		deny: (creator canCreate: #(1));
		deny: (creator canCreate: 1)
]

{ #category : #tests }
ModelCollectorTest >> testChangeModelToIn [

	| creator picker |

	picker := self newSingleModelPickerNamed: 'Options'.
	picker allowAnyOf: 'ABCDEFG'.
	creator := ModelCollector named: 'Mix' containing: (Array with: (self newFixedCreatorFor: 1) with: picker).

	self
		assertModelCreationFailedFor: picker;
		assertModelCreationFailedFor: creator.

	creator updateModelInViewsConsidering: #(2 $A).

	self
		assertModelAssembledBy: creator equals: #(1 $A);
		assertModelAssembledBy: picker equals: $A
]

{ #category : #tests }
ModelCollectorTest >> testModelIn [

	| creator |

	creator := ModelCollector named: 'Numbers' containing: (Array with: (self newFixedCreatorFor: 1) with: (self newFixedCreatorFor: 2)).

	self assertModelAssembledBy: creator equals: #(1 2)
]
