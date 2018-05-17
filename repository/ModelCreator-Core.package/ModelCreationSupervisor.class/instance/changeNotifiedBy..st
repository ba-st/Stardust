changing
changeNotifiedBy: aView

	| relatedCreator affectedCreators |

	relatedCreator := self creatorRelatedTo: aView.
	affectedCreators := creationSequence creatorsAffectedByChangeIn: relatedCreator.
	affectedCreators do: [ :creator | context invalidateModelFor: creator ]