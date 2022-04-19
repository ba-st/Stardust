Class {
	#name : #BaselineOfStardust,
	#superclass : #BaselineOf,
	#category : 'BaselineOfStardust'
}

{ #category : #baselines }
BaselineOfStardust >> baseline: spec [

	<baseline>
	spec
		for: #pharo
		do: [ self
				setUpDependencies: spec;
				baselineStardust: spec.
			spec
				group: 'CI' with: 'Tests';
				group: 'Tools' with: 'Buoy-Tools';
				group: 'Development' with: #('Tests' 'Tools')
			]
]

{ #category : #baselines }
BaselineOfStardust >> baselineStardust: spec [

	spec
		package: 'Stardust' with: [ spec requires: #('Buoy-Deployment' 'Mole-Deployment') ];
		group: 'Deployment' with: 'Stardust';
		package: 'Stardust-Tests' with: [ spec requires: #('Stardust' 'Buoy-SUnit') ];
		group: 'Tests' with: 'Stardust-Tests'
]

{ #category : #accessing }
BaselineOfStardust >> projectClass [

	^ MetacelloCypressBaselineProject
]

{ #category : #baselines }
BaselineOfStardust >> setUpDependencies: spec [

	spec
		baseline: 'Buoy' with: [ spec repository: 'github://ba-st/Buoy:v6' ];
		project: 'Buoy-Deployment' copyFrom: 'Buoy' with: [ spec loads: 'Deployment' ];
		project: 'Buoy-SUnit' copyFrom: 'Buoy' with: [ spec loads: 'Dependent-SUnit-Extensions' ];
		project: 'Buoy-Tools' copyFrom: 'Buoy' with: [ spec loads: 'Tools' ].

	spec
		baseline: 'Mole' with: [ spec repository: 'github://ba-st/Mole:v3' ];
		project: 'Mole-Deployment' copyFrom: 'Mole' with: [ spec loads: 'Deployment' ]
]
