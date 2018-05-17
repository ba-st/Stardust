asserting
assertSizeOf: aModelCreatorCollection equalsSizeOf: aSelectorCollection

	AssertionChecker
		enforce: [ aModelCreatorCollection size = aSelectorCollection size ]
		because:
			('The amount of model creators (<1p>) should match the amount of accessors (<2p>) used to set the model.'
				expandMacrosWith: aModelCreatorCollection size
				with: aSelectorCollection size)
		raising: InstanceCreationFailed