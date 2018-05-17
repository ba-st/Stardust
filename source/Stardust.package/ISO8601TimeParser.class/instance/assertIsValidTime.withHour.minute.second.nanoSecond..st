private
assertIsValidTime: aString withHour: hours minute: minutes second: seconds nanoSecond: nanoSeconds

	AssertionCheckerBuilder new
		raising: ParsingFailed;
		checking: [ :asserter | 
			asserter
				enforce: [ hours between: 0 and: 23 ] because: ('Hours ''<1p>'' should be between 0 and 23 in: <2p>' expandMacrosWith: hours with: aString);
				enforce: [ minutes between: 0 and: 59 ] because: ('Minutes ''<1p>'' should be between 0 and 59 in: <2p>' expandMacrosWith: minutes with: aString);
				enforce: [ seconds between: 0 and: 59 ] because: ('Seconds ''<1p>'' should be between 0 and 59 in: <2p>' expandMacrosWith: minutes with: aString);
				enforce: [ nanoSeconds between: 0 and: 999999999 ] because: ('Nano ''<1p>'' should be between 0 and 999999999 in: <2p>' expandMacrosWith: minutes with: aString) ];
		buildAndCheck