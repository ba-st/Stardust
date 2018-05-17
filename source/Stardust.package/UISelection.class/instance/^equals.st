comparing
= anObject

	^ self == anObject or: [ (self isAn: anObject class) and: [ selection = anObject selection ] ]