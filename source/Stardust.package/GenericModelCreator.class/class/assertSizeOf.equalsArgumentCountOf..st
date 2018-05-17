asserting
assertSizeOf: aModelCreatorCollection equalsArgumentCountOf: aSelector

	AssertionChecker
		enforce: [ aModelCreatorCollection size = aSelector argumentCount ]
		because:
			('The amount of model creators (<1p>) should match the amount of arguments (<2p>) on the instance creation message: <3p>'
				expandMacrosWith: aModelCreatorCollection size
				with: aSelector argumentCount
				with: aSelector)
		raising: InstanceCreationFailed