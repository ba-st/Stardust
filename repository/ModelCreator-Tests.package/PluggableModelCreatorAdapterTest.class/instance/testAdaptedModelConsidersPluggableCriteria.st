tests
testAdaptedModelConsidersPluggableCriteria

	| creator pluggable |

	creator := ContainerController named: 'text' controlling: TextInputViewExample new.
	pluggable := PluggableModelCreatorAdapter adapting: creator with: [ :adapteeModel | adapteeModel asUppercase ].
	creator changeModelTo: 'some lowercase input' in: self.
	self assert: (pluggable modelIn: self) equals: 'SOME LOWERCASE INPUT'