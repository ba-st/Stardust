baselines
baseline: spec

	<baseline>
	spec
		for: #common
		do: [ 
			self setUpDependencies: spec.
			
			spec
				package: 'Stardust' with: [ spec requires: 'Buoy' ];
				package: 'Stardust-Tests' with: [ spec requires: 'Stardust' ].
			
			spec
				group: 'Deployment' with: #('Stardust');
				group: 'Development' with: #('Stardust-Tests');
				group: 'default' with: #('Deployment') ]