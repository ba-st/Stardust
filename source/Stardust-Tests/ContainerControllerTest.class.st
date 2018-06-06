Class {
	#name : #ContainerControllerTest,
	#superclass : #TestCase,
	#category : #'Stardust-Tests-ModelCreation'
}

{ #category : #tests }
ContainerControllerTest >> testAfterChangeOfContentsModelObtainedRepresentsNewContents [

	| creator |

	creator := ContainerController named: 'text' controlling: DummyTextInput new.
	creator changeModelTo: 'new text' in: self.
	self assert: (creator modelIn: self) equals: 'new text'
]

{ #category : #tests }
ContainerControllerTest >> testAfterChangeOfContentsModelPreviouslyObtainedIsUnaffected [

	| previousModel creator |

	creator := ContainerController named: 'text' controlling: DummyTextInput new.
	creator changeModelTo: 'old text' in: self.
	previousModel := creator modelIn: self.
	creator changeModelTo: 'new text' in: self.
	self assert: previousModel equals: 'old text'
]
