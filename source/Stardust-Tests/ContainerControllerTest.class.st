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

	creator := ContainerController named: 'First Name' controlling: self newTextField.

	self
		assert: (creator canCreate: '');
		assert: (creator canCreate: 'Gabriel')
]

{ #category : #tests }
ContainerControllerTest >> testChangeModelToIn [

	| creator |

	creator := ContainerController named: 'First Name' controlling: self newTextField.

	self assertModelAssembledBy: creator equals: ''.

	creator updateModelInViewsConsidering: 'Gabriel'.

	self assertModelAssembledBy: creator equals: 'Gabriel'
]

{ #category : #tests }
ContainerControllerTest >> testModelIn [

	| creator |

	creator := ContainerController named: 'First Name' controlling: self newTextField.
	
	self assertModelAssembledBy: creator equals: ''
]
