accessing
currentSelectionIfNone: aBlock

	^ chosenElement withContentDo: [ :element | element ] ifUnused: aBlock