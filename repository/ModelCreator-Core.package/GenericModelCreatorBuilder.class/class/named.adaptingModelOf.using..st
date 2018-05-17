instance creation
named: aName adaptingModelOf: aModelCreator using: aBlock

	^ (self named: aName building: aBlock accessedOnlyUsing: #()) value: aModelCreator