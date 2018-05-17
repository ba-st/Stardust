testing
canCreate: aModelCollection

	^ aModelCollection allSatisfy: [ :aModelElement | view allowsAnySatisfying: [ :element | element representedObject = aModelElement ] ]