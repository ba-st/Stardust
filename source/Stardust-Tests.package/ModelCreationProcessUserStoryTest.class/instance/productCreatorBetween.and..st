private - accessing
productCreatorBetween: aFirstCreator and: aSecondCreator

	| codec operandsCreator |

	codec := self numberCodecFor: aSecondCreator.
	
	operandsCreator := ModelCollector
		named: 'product-operands'
		containing: (Array with: aFirstCreator with: codec).

	^ GenericModelCreatorBuilder
		named: 'product'
		adaptingModelOf: operandsCreator
		using: [ :operands | operands first * operands last ]