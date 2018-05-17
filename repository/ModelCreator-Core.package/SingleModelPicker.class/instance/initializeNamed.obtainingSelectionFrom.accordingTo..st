initialization
initializeNamed: aName obtainingSelectionFrom: aSingleSelectionView accordingTo: aModelPickingPolicy

	name := aName.
	view := aSingleSelectionView.
	"Esto deberÌa morir cuando se dejen de usar los UI representation adentro de las selecciones. Para eso est· el LabelingCommand - gabriel"
	pickingPolicy := aModelPickingPolicy