tests
testAfterChangeOfContentsModelObtainedRepresentsNewContents

	| creator |

	creator := ContainerController named: 'text' controlling: TextInputViewExample new.
	creator changeModelTo: 'new text' in: self.
	self assert: (creator modelIn: self) equals: 'new text'