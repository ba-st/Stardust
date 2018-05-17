initialization
setUpPackages: spec

	spec
		package: 'ModelCreator-Core';
		package: 'ModelCreator-Views' with: [ spec requires: 'ModelCreator-Core' ];
		package: 'ModelCreator-Views-Examples' with: [ spec requires: 'ModelCreator-Views' ];
		package: 'ModelCreator-Tests' with: [ spec requires: 'ModelCreator-Views-Examples' ]