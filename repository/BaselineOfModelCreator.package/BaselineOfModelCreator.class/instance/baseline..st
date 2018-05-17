baselines
baseline: spec

	<baseline>
	spec
		for: #common
		do: [ self
				setUpDependencies: spec;
				setUpPackages: spec;
				setUpGroups: spec ]