Class {
	#name : #PluggableModelCreatorAdapterTest,
	#superclass : #TestCase,
	#category : 'Stardust-Tests-ModelCreator'
}

{ #category : #'private - accessing' }
PluggableModelCreatorAdapterTest >> modelFor: aCreator [

	^ aCreator modelIn: self
]

{ #category : #tests }
PluggableModelCreatorAdapterTest >> testAdaptedModelConsidersPluggableCriteria [

	| creator pluggable |

	creator := ContainerController named: 'text' controlling: DummyTextInput new.
	pluggable := PluggableModelCreatorAdapter adapting: creator with: [ :adapteeModel | adapteeModel asUppercase ].
	creator changeModelTo: 'some lowercase input' in: self.
	self assert: (pluggable modelIn: self) equals: 'SOME LOWERCASE INPUT'
]
