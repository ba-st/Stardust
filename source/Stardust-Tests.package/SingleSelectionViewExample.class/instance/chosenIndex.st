private-accessing
chosenIndex

	^ chosenElement withContentDo: [ :selection | availableElements indexOf: selection ] ifUnused: [ 0	"Same behavior as SequentiableCollection" ]