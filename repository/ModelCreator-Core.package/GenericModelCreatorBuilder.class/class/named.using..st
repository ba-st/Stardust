instance creation
named: aName using: aBlock

	^ (self named: aName building: aBlock accessedOnlyUsing: #()) value