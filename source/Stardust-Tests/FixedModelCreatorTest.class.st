"
I'm a test case
"
Class {
	#name : #FixedModelCreatorTest,
	#superclass : #ModelCreatorTest,
	#category : #'Stardust-Tests-ModelCreation'
}

{ #category : #tests }
FixedModelCreatorTest >> testCanCreate [

	| creator |

	creator := FixedModelCreator creating: 30 percent.

	self
		assert: (creator canCreate: 30 percent);
		deny: (creator canCreate: 55 percent);
		deny: (creator canCreate: nil)
]

{ #category : #tests }
FixedModelCreatorTest >> testChangeInModelHasNoEffect [

	| creator |

	creator := FixedModelCreator creating: 30 percent.
	creator changeModelTo: 55 in: context.
	self assert: (creator modelIn: context) equals: 30 percent
]

{ #category : #tests }
FixedModelCreatorTest >> testModelIn [

	| creator |

	creator := FixedModelCreator creating: 30 percent.
	self assert: (creator modelIn: context) equals: 30 percent
]
