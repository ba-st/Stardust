accessing
modelIn: aContext

	^ view currentSelection collect: [ :element | element representedObject ]