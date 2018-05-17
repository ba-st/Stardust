private-parsing
basicParse: stream

	| offset date time |

	date := ISO8601DateParser new parse: (stream upTo: $T).
	time := ISO8601TimeParser new parse: (self extractTimeFrom: stream).
	offset := self parseOffsetFrom: stream upToEnd.

	^ DateAndTime
		year: date year
		month: date monthIndex
		day: date dayOfMonth
		hour: time hour
		minute: time minute
		second: time second
		nanoSecond: time nanoSecond
		offset: offset