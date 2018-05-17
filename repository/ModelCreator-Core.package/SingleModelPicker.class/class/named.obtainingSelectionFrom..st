instance creation
named: aName obtainingSelectionFrom: aSingleSelectionView

	self
		deprecated:
			'Deberiamos eliminar el uso de los UIRepresentation,
			todas las view de selection tienen alguna forma de configurarles que mostrar, generalmente usando el ListLabelingCommand.
			Cuando se eliminen los usos se puede borrar la jerarquia de ModelPickingPolicy'.

	^ self named: aName obtainingSelectionFrom: aSingleSelectionView accordingTo: PickUIRepresentationPolicy new