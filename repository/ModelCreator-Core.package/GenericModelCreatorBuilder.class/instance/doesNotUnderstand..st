reflective operations
doesNotUnderstand: aMessage

	^ self
		creatorInstanceUsing:
			(OrderedCollection new
				add: name;
				add: modelClass;
				add: aMessage selector;
				add: aMessage arguments;
				add: accessors;
				asArray)