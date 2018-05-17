accessing
creatorsAffectedByChangeIn: aCreator

	| affectedCreators |

	affectedCreators := Set with: aCreator.
	(creationGraph edgesStartingOn: aCreator) do: [ :edge | affectedCreators addAll: (self creatorsAffectedByChangeIn: edge target) ].
	^ affectedCreators