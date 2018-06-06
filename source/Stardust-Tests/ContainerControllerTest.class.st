"
I'm a test case
"
Class {
	#name : #ContainerControllerTest,
	#superclass : #ModelCreatorTest,
	#category : #'Stardust-Tests-ModelCreation'
}

{ #category : #tests }
ContainerControllerTest >> testCanCreate [

	| creator |

	creator := ContainerController named: 'First Name' controlling: self textField.

	self
		assert: (creator canCreate: '');
		assert: (creator canCreate: 'Gabriel')
]

{ #category : #tests }
ContainerControllerTest >> testChangeModelToIn [

	| creator |

	creator := ContainerController named: 'First Name' controlling: self textField.
	creator changeModelTo: 'Gabriel' in: context.

	self assert: (creator modelIn: context) equals: 'Gabriel'
]

{ #category : #tests }
ContainerControllerTest >> testModelIn [

	| creator |

	creator := ContainerController named: 'First Name' controlling: self textField.
	self assert: (creator modelIn: context) isEmpty
]
