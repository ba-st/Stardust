private - accessing
productCreatorBetween: aFirstCreator and: aSecondCreator

	| codec operandsCreator |

	codec := self numberCodecFor: aSecondCreator.
	operandsCreator := ModelCollector named: 'sum-operands' containing: (Array with: aFirstCreator with: codec).
	^ GenericModelCreatorBuilder named: 'sum' adaptingModelOf: operandsCreator using: [ :operands | operands sum ]