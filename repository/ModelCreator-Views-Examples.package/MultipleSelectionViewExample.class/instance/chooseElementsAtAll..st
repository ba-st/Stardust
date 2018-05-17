selection protocol
chooseElementsAtAll: anIndexCollection

	self setChosenElementsTo: (anIndexCollection collect: [ :index | availableElements at: index ])