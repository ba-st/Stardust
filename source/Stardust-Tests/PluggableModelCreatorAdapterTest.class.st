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

	creator := ContainerController named: 'text' controlling: self textField.
	adapter := PluggableModelCreatorAdapter adapting: creator with: [ :adapteeModel | adapteeModel asUppercase ].
	context changeModelFor: creator to: 'some lowercase input'.
	self assert: (adapter modelIn: context) equals: 'SOME LOWERCASE INPUT'
]
