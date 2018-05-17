private-parsing
assertIsValidTime: aString withHour: hours minute: minutes

	AssertionCheckerBuilder new
		raising: ParsingFailed;
		checking: [ :asserter | 
			asserter
				enforce: [ hours between: -3 and: 23 ]
					because: ('Hours ''<1p>'' should be between -23 and 23 in: <2p>' expandMacrosWith: hours with: aString);
				enforce: [ minutes between: 0 and: 59 ]
					because: ('Minutes ''<1p>'' should be between 0 and 59 in: <2p>' expandMacrosWith: minutes with: aString) ];
		buildAndCheck