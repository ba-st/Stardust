Class {
	#name : #GenericModelCreatorBuilder,
	#superclass : #ProtoObject,
	#instVars : [
		'modelClass',
		'accessors',
		'name',
		'creatorInstantiator'
	],
	#category : #Stardust
}

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

{ #category : #'private-accessing' }
GenericModelCreatorBuilder >> creatorInstanceUsing: instanceCreationArguments [

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

{ #category : #initialization }
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

	^ String streamContents: [ :stream | self printOn: stream ]
]

{ #category : #'reflective operations' }
GenericModelCreatorBuilder >> respondsTo: aSymbol [

	^ (self class canUnderstand: aSymbol) or: [ modelClass respondsTo: aSymbol ]
]
