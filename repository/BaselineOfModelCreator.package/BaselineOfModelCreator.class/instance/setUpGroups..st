initialization
setUpGroups: spec

	spec
		group: 'Deployment' with: #('ModelCreator-Core' 'ModelCreator-Views');
		group: 'Development' with: #('Deployment' 'ModelCreator-Tests' 'ModelCreator-Examples');
		group: 'default' with: #('Deployment')