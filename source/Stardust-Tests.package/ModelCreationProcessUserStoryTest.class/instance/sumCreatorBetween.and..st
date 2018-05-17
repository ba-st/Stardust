private - accessing
sumCreatorBetween: aFirstCreator and: aSecondCreator

	^ (GenericModelCreatorBuilder named: 'sum' building: Array accessedUsing: #(first last)) with: aFirstCreator with: aSecondCreator