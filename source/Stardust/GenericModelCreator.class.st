"
I'm a composite model creator. I'm intended to create complex objects.
"
Class {
	#name : #GenericModelCreator,
	#superclass : #CompositeModelCreator,
	#instVars : [
		'accessors',
		'instanceCreationSelector',
		'modelClassReference',
		'modelCreators',
		'name'
	],
	#category : #Stardust
}

{ #category : #'private - asserting' }
GenericModelCreator class >> assertSizeOf: aModelCreatorCollection equalsArgumentCountOf: aSelector [

	AssertionChecker
		enforce: [ aModelCreatorCollection size = aSelector argumentCount ]
		because:
			('The amount of model creators (<1p>) should match the amount of arguments (<2p>) on the instance creation message: <3p>'
				expandMacrosWith: aModelCreatorCollection size
				with: aSelector argumentCount
				with: aSelector)
		raising: InstanceCreationFailed
]

{ #category : #'private - asserting' }
GenericModelCreator class >> assertSizeOf: aModelCreatorCollection equalsSizeOf: aSelectorCollection [

	AssertionChecker
		enforce: [ aModelCreatorCollection size = aSelectorCollection size ]
		because:
			('The amount of model creators (<1p>) should match the amount of accessors (<2p>) used to set the model.'
				expandMacrosWith: aModelCreatorCollection size
				with: aSelectorCollection size)
		raising: InstanceCreationFailed
]

{ #category : #'instance creation' }
GenericModelCreator class >> named: aName creatingInstancesOf: modelClass sending: aSelector with: aModelCreatorCollection accessingModelOnlyWith: aSelectorCollection [

	self assertNotEmpty: aName.
	self assertSizeOf: aModelCreatorCollection equalsArgumentCountOf: aSelector.

	^ self new
		initializeNamed: aName
		creatingInstancesOf: modelClass
		sending: aSelector
		with: aModelCreatorCollection
		accessingModelOnlyWith: aSelectorCollection
]

{ #category : #'instance creation' }
GenericModelCreator class >> named: aName creatingInstancesOf: modelClass sending: aSelector with: aModelCreatorCollection accessingModelWith: aSelectorCollection [

	self assertSizeOf: aModelCreatorCollection equalsSizeOf: aSelectorCollection.

	^ self
		named: aName
		creatingInstancesOf: modelClass
		sending: aSelector
		with: aModelCreatorCollection
		accessingModelOnlyWith: aSelectorCollection
]

{ #category : #testing }
GenericModelCreator >> canCreate: aModel [

	^ (self modelClass isClass not or: [ aModel isA: self modelClass ])
		and: [ | allowedByAccessors |

			allowedByAccessors := true.
			accessors
				with: (modelCreators first: accessors size)
				do: [ :accessor :modelCreator | allowedByAccessors := allowedByAccessors and: [ modelCreator canCreate: (aModel perform: accessor) ] ].
			allowedByAccessors ]
]

{ #category : #disassembling }
GenericModelCreator >> changeModelTo: aModel in: aContext [

	accessors
		with: (modelCreators first: accessors size)
		do: [ :accessor :modelCreator | aContext changeModelFor: modelCreator to: (aModel perform: accessor) ]
]

{ #category : #enumerating }
GenericModelCreator >> dependenciesDo: aBlock [

	^ modelCreators do: aBlock
]

{ #category : #initialization }
GenericModelCreator >> initializeNamed: aName creatingInstancesOf: aModelClassOrBlock sending: aSelector with: aModelCreatorCollection accessingModelOnlyWith: aSelectorCollection [

	name := aName.
	modelClassReference := aModelClassOrBlock isClass
		ifTrue: [ aModelClassOrBlock ]
		ifFalse: [ "The block inside block is intentional. See self>>#modelIn:" [ aModelClassOrBlock ] ].

	instanceCreationSelector := aSelector.
	modelCreators := aModelCreatorCollection.
	accessors := aSelectorCollection
]

{ #category : #private }
GenericModelCreator >> modelClass [

	^ modelClassReference value
]

{ #category : #private }
GenericModelCreator >> modelCreators [

	^ modelCreators
]

{ #category : #assembling }
GenericModelCreator >> modelIn: aContext [

	| models |

	models := modelCreators collect: [ :modelCreator | aContext modelFor: modelCreator ].
	^ self modelClass perform: instanceCreationSelector withArguments: models
]

{ #category : #accessing }
GenericModelCreator >> name [

	^ name
]
