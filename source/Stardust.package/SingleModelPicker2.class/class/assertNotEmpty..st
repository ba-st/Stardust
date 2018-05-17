preconditions
assertNotEmpty: aName

	AssertionChecker enforce: [ aName isNotEmpty ] because: 'Name cannot be empty'