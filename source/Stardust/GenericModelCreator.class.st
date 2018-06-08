"
I'm a composite model creator. I'm intended to create complex objects.
"
Class {
	#name : #GenericModelCreator,
	#superclass : #CompositeModelCreator,
	#instVars : [
		'accessors',
		'instanceCreationSelector',
		'modelCreators',
		'name',
		'modelClass'
	],
	#category : #Stardust
}

{ #category : #'private - asserting' }
GenericModelCreator class >> assertSizeOf: creators equalsArgumentCountOf: instanceCreationSelector [

	AssertionChecker
		enforce: [ creators size = instanceCreationSelector argumentCount ]
		because: [ 'The amount of model creators (<1p>) should match the amount of arguments (<2p>) on the instance creation message: <3p>'
				expandMacrosWith: creators size
				with: instanceCreationSelector argumentCount
				with: instanceCreationSelector ]
		raising: InstanceCreationFailed
]

{ #category : #'private - asserting' }
GenericModelCreator class >> assertSizeOf: creators equalsSizeOf: accessors [

	AssertionChecker
		enforce: [ creators size = accessors size ]
		because: [ 'The amount of model creators (<1p>) should match the amount of accessors (<2p>) used to set the model.' expandMacrosWith: creators size with: accessors size ]
		raising: InstanceCreationFailed
]

{ #category : #'instance creation' }
GenericModelCreator class >> named: aName creatingInstancesOf: modelClass sending: instanceCreationSelector with: childCreators accessingModelOnlyWith: accessors [

	self
		assertNotEmpty: aName;
		assertSizeOf: childCreators equalsArgumentCountOf: instanceCreationSelector.

	^ self new
		initializeNamed: aName
		creatingInstancesOf: modelClass
		sending: instanceCreationSelector
		with: childCreators
		accessingModelOnlyWith: accessors
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

	^ (aModel isA: modelClass)
		and: [ | allowedByAccessors |

			allowedByAccessors := true.
			self
				withAccessorsAndCreatorsDo: [ :accessor :creator | 
					allowedByAccessors := allowedByAccessors
						and: [ creator canCreate: (aModel perform: accessor) ] ].
			allowedByAccessors ]
]

{ #category : #disassembling }
GenericModelCreator >> changeModelTo: aModel in: aContext [

	self withAccessorsAndCreatorsDo: [ :accessor :modelCreator | aContext changeModelFor: modelCreator to: (aModel perform: accessor) ]
]

{ #category : #enumerating }
GenericModelCreator >> dependenciesDo: aBlock [

	^ modelCreators do: aBlock
]

{ #category : #initialization }
GenericModelCreator >> initializeNamed: aName creatingInstancesOf: aModelClass sending: aSelector with: aModelCreatorCollection accessingModelOnlyWith: aSelectorCollection [

	name := aName.
	modelClass := aModelClass.
	instanceCreationSelector := aSelector.
	modelCreators := aModelCreatorCollection.
	accessors := aSelectorCollection
]

{ #category : #assembling }
GenericModelCreator >> modelIn: aContext [

	| models |

	models := modelCreators collect: [ :modelCreator | aContext modelFor: modelCreator ].
	^ modelClass perform: instanceCreationSelector withArguments: models
]

{ #category : #accessing }
GenericModelCreator >> name [

	^ name
]

{ #category : #private }
GenericModelCreator >> withAccessorsAndCreatorsDo: aBlock [

	"We allow to have less accessors than creators"

	accessors with: (modelCreators first: accessors size) do: aBlock
]
