accessing
changeModelTo: aCollection in: aContext

	view
		choose: aCollection
		matchedUsing: [ :model :selectableElement | model = selectableElement representedObject ]
		ifUnable: [ ProgrammingError signal: 'Selected elements are not valid' ]