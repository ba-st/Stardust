testing
canCreate: aModel

	^ view allowsAnySatisfying: [ :element | pickingPolicy is: element equalTo: aModel ]