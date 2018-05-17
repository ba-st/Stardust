private-parsing
extractTimeFrom: stream

	| timeAndOffset timeLength |

	timeAndOffset := stream contents copyFrom: stream position to: stream size.
	timeLength := ('+-Z' max: [ :c | timeAndOffset indexOf: c ]) - 1.
	^ stream next: timeLength - 1