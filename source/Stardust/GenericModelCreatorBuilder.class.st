Class {
	#name : #GenericModelCreatorBuilder,
	#superclass : #ProtoObject,
	#instVars : [
		'modelClass',
		'accessors',
		'name',
		'creatorInstantiator'
	],
	#category : 'Stardust-ModelCreator'
}

{ #category : #'instance creation' }
GenericModelCreatorBuilder class >> named: aName adaptingModelOf: aModelCreator using: aBlock [

	^ (self named: aName building: aBlock accessedOnlyUsing: #()) value: aModelCreator
]

{ #category : #'instance creation' }
GenericModelCreatorBuilder class >> named: aName building: aModelClass accessedOnlyUsing: aCollectionOfSelectors [

	^ self
		named: aName
		building: aModelClass
		accessedUsing: aCollectionOfSelectors
		creatingInstanceOfCreatorWith: #named:creatingInstancesOf:sending:with:accessingModelOnlyWith:
]

{ #category : #'instance creation' }
GenericModelCreatorBuilder class >> named: aName building: aModelClass accessedUsing: aCollectionOfSelectors [

	^ self
		named: aName
		building: aModelClass
		accessedUsing: aCollectionOfSelectors
		creatingInstanceOfCreatorWith: #named:creatingInstancesOf:sending:with:accessingModelWith:
]

{ #category : #'private-instance creation' }
GenericModelCreatorBuilder class >> named: aName building: aModelClass accessedUsing: aCollectionOfSelectors creatingInstanceOfCreatorWith: anInstanceCreationSelector [

	^ self new
		initializeNamed: aName
		building: aModelClass
		accessedUsing: aCollectionOfSelectors
		creatingInstanceOfCreatorWith: anInstanceCreationSelector
]

{ #category : #'instance creation' }
GenericModelCreatorBuilder class >> named: aName using: aBlock [

	^ (self named: aName building: aBlock accessedOnlyUsing: #()) value
]

{ #category : #'private-accessing' }
GenericModelCreatorBuilder >> creatorInstanceUsing: instanceCreationArguments [

	"Para compatibilidad con GemStone. -mtabacman"

	^ GenericModelCreator perform: creatorInstantiator withArguments: instanceCreationArguments
]

{ #category : #'reflective operations' }
GenericModelCreatorBuilder >> doesNotUnderstand: aMessage [

	^ self
		creatorInstanceUsing:
			(OrderedCollection new
				add: name;
				add: modelClass;
				add: aMessage selector;
				add: aMessage arguments;
				add: accessors;
				asArray)
]

{ #category : #'private-accessing' }
GenericModelCreatorBuilder >> initializeNamed: aName building: aModelClass accessedUsing: aCollectionOfSelectors creatingInstanceOfCreatorWith: anInstanceCreationSelector [

	name := aName.
	modelClass := aModelClass.
	accessors := aCollectionOfSelectors.
	creatorInstantiator := anInstanceCreationSelector
]

{ #category : #printing }
GenericModelCreatorBuilder >> printOn: aStream [

	aStream nextPutAll: (#'Creation of <1s> using <2s>' expandMacrosWith: modelClass asString with: (CollectionFormatter new format: accessors))
]

{ #category : #printing }
GenericModelCreatorBuilder >> printString [

	"Implementado para evitar que lo agarre el DNU. -mtabacman"

	^ String streamContents: [ :stream | self printOn: stream ]
]

{ #category : #'reflective operations' }
GenericModelCreatorBuilder >> respondsTo: aSelector [

	^ (self class canUnderstand: aSelector)
		or: [ [ modelClass respondsTo: aSelector ]
				on: InstanceCreationFailed
				do: [ :aSignal | aSignal return: false ] ]
]
