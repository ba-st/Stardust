printing
printOn: aStream

	aStream nextPutAll: (#'Creation of <1s> using <2s>' expandMacrosWith: modelClass asString with: (CollectionFormatter new format: accessors))