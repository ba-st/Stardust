accessing
chosenIndexes

	^ chosenElements collect: [ :chosenElement | availableElements indexOf: chosenElement ]