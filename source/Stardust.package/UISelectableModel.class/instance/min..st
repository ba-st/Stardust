accessing
min: aUISelectableModel

	^ self < aUISelectableModel
		ifTrue: [ self ]
		ifFalse: [ aUISelectableModel ]