private - accessing
sumCreatorBetween: aFirstCreator and: aSecondCreator

	| operandsCreator |

	operandsCreator := ModelCollector
		named: 'sum-operands'
		containing: (Array with: aFirstCreator with: aSecondCreator).

	^ GenericModelCreatorBuilder
		named: 'sum'
		adaptingModelOf: operandsCreator
		using: [ :operands | operands sum ]