private
assertIsValidDate: aString withYear: year month: monthIndex day: dayOfMonth

	AssertionCheckerBuilder new
		raising: ParsingFailed;
		checking: [ :asserter | 
			| daysInMonth |

			daysInMonth := Date daysInMonth: monthIndex forYear: year.
			asserter
				enforce: [ monthIndex between: 1 and: 12 ] because: ('Month ''<1p>'' should be between 1 and 12 in: <2p>' expandMacrosWith: monthIndex with: aString);
				enforce: [ dayOfMonth between: 1 and: daysInMonth ] because: ('Day of month ''<1p>'' should be between 1 and <2p> in: <3p>' expandMacrosWith: monthIndex with: daysInMonth with: aString) ];
		buildAndCheck