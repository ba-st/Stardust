Class {
	#name : #BaselineOfStardust,
	#superclass : #BaselineOf,
	#category : 'BaselineOfStardust'
}

{ #category : #baselines }
BaselineOfStardust >> baseline: spec [

	<baseline>
	spec
		for: #common
		do: [ 
			self setUpDependencies: spec.
			
			spec
				package: 'Stardust' with: [ spec requires: #('Buoy' 'Mole') ];
				package: 'Stardust-Tests' with: [ spec requires: 'Stardust' ].
			
			spec
				group: 'Deployment' with: #('Stardust');
				group: 'Development' with: #('Stardust-Tests');
				group: 'default' with: #('Deployment') ]
]

{ #category : #baselines }
BaselineOfStardust >> setUpDependencies: spec [

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
]
