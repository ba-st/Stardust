initialization
parse: aString

	| stream sign |

	self assertWellFormed: aString.
	stream := (thousandsSeparator withContentDo: [ :sep | aString copyWithout: sep ] ifUnused: [ aString ]) readStream.
	sign := self parseSignFrom: stream.
	^ sign * stream upToEnd asNumber