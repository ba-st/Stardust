user interaction simulation
chosenIndex

	^ availableElements indexOf: (chosenElement withContentDo: [:element | element ] ifUnused: [ self halt ])