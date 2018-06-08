"
I'm a test case
"
Class {
	#name : #PluggableModelCreatorAdapterTest,
	#superclass : #ModelCreatorTest,
	#category : #'Stardust-Tests-ModelCreation'
}

{ #category : #tests }
PluggableModelCreatorAdapterTest >> testAdaptedModelConsidersPluggableCriteria [

	| creator adapter |

	creator := ContainerController named: 'text' controlling: self newTextField.
	adapter := PluggableModelCreatorAdapter adapting: creator with: [ :adapteeModel | adapteeModel asUppercase ].
	creator updateModelInViewsConsidering: 'some lowercase input'.
	self assertModelAssembledBy: adapter equals: 'SOME LOWERCASE INPUT'
]
