Class {
	#name : #FixedModelCreatorTest,
	#superclass : #TestCase,
	#category : 'Stardust-Tests-ModelCreator'
}

{ #category : #tests }
FixedModelCreatorTest >> testChangeInModelHasNoEffect [

	| creator |

	creator := FixedModelCreator creating: (Percentage of: 30).
	creator changeModelTo: (Percentage of: 55) in: self.
	self assert: (creator modelIn: self) equals: (Percentage of: 30)
]

{ #category : #tests }
FixedModelCreatorTest >> testProvidedModelIsAlwaysUsed [

	| creator |

	creator := FixedModelCreator creating: (Percentage of: 30).
	self assert: (creator modelIn: self) equals: (Percentage of: 30)
]
