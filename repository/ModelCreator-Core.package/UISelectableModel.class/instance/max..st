accessing
max: aUISelectableModel

	^ self < aUISelectableModel
		ifTrue: [ aUISelectableModel ]
		ifFalse: [ self ]