preconditions
assertNotEmpty: aName

	AssertionChecker enforce: [ aName trimBoth notEmpty ] because: 'A model creator must have a name' raising: InstanceCreationFailed