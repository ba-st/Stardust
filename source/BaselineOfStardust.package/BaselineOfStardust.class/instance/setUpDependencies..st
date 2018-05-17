baselines
setUpDependencies: spec

	spec
		baseline: 'Buoy'
		with: [ spec
				repository: 'github://ba-st/Buoy:v4/source';
				loads: #('Deployment') ].

	spec
		baseline: 'Mole'
		with: [ spec
				repository: 'github://ba-st/Mole:master/source';
				loads: #('Deployment') ].