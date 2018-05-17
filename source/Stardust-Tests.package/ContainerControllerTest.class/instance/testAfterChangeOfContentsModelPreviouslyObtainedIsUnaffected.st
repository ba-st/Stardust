tests
testAfterChangeOfContentsModelPreviouslyObtainedIsUnaffected

	| previousModel creator |

	creator := ContainerController named: 'text' controlling: TextInputViewExample new.
	creator changeModelTo: 'old text' in: self.
	previousModel := creator modelIn: self.
	creator changeModelTo: 'new text' in: self.
	self assert: previousModel equals: 'old text'