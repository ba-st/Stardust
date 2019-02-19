"
I'm a test case for GenericModelCreator
"
Class {
	#name : #GenericModelCreatorTest,
	#superclass : #CompositeModelCreatorTest,
	#category : #'Stardust-Tests-ModelCreation'
}

{ #category : #tests }
GenericModelCreatorTest >> testBuilderPrintString [

	self
		assert:
			( GenericModelCreatorBuilder
				named: 'Paper'
				building: StardustPaper
				accessedUsing: #(title authorName rating) ) printString
		equals: 'Creation of StardustPaper using #(#title #authorName #rating)'
]

{ #category : #tests }
GenericModelCreatorTest >> testBuilderRespondsTo [

	self
		assert:
			( ( GenericModelCreatorBuilder
				named: 'Paper'
				building: StardustPaper
				accessedUsing: #(title authorName rating) ) respondsTo: #titled:authoredBy:rated: )
]

{ #category : #tests }
GenericModelCreatorTest >> testCanCreate [

	| creator authorPicker ratingPicker |

	authorPicker := self newSingleModelPickerNamed: 'Author Name'.
	ratingPicker := self newSingleModelPickerNamed: 'Rating'.

	creator := (GenericModelCreatorBuilder named: 'Paper' building: StardustPaper accessedUsing: #(title authorName rating))
		titled: (self newContainerControllerNamed: 'Title')
		authoredBy: authorPicker
		rated: ratingPicker.

	authorPicker allowAnyOf: #('Alan Turing' 'Albert Einstein').
	ratingPicker allowAnyOf: #(1 2 3 5).

	self
		assert: (creator canCreate: (StardustPaper titled: 'Computing Machinery and Intelligence' authoredBy: 'Alan Turing' rated: 5));
		deny: (creator canCreate: (StardustPaper titled: 'Computing Machinery and Intelligence' authoredBy: 'Alonzo Church' rated: 5));
		deny: (creator canCreate: (StardustPaper titled: 'Computing Machinery and Intelligence' authoredBy: 'Alan Turing' rated: 4));
		assert: (creator canCreate: (StardustPaper titled: 'General relativity' authoredBy: 'Albert Einstein' rated: 3));
		deny: (creator canCreate: 8)
]

{ #category : #tests }
GenericModelCreatorTest >> testChangeModelTo [

	| creator ratingPicker paper titleContainer authorNameContainer |

	ratingPicker := self newSingleModelPickerNamed: 'Rating'.
	titleContainer := self newContainerControllerNamed: 'Title'.
	authorNameContainer := self newContainerControllerNamed: 'Author Name'.
	creator := (GenericModelCreatorBuilder named: 'Paper' building: StardustPaper accessedUsing: #(title authorName rating)) titled: titleContainer authoredBy: authorNameContainer rated: ratingPicker.

	ratingPicker allowAnyOf: #(1 2 3 4 5).

	self
		assertModelCreationFailedFor: ratingPicker;
		assertModelAssembledBy: titleContainer equals: '';
		assertModelAssembledBy: authorNameContainer equals: '';
		assertModelCreationFailedFor: creator.

	creator updateModelInViewsConsidering: (StardustPaper titled: 'Computing Machinery and Intelligence' authoredBy: 'Alan Turing' rated: 5).

	paper := self modelAssembledBy: creator.

	self
		assert: paper title equals: 'Computing Machinery and Intelligence';
		assert: paper authorName equals: 'Alan Turing';
		assert: paper rating equals: 5.

	self
		assertModelAssembledBy: ratingPicker equals: 5;
		assertModelAssembledBy: titleContainer equals: 'Computing Machinery and Intelligence';
		assertModelAssembledBy: authorNameContainer equals: 'Alan Turing'
]

{ #category : #tests }
GenericModelCreatorTest >> testChangeModelToWithLessAccessors [

	| creator ratingPicker paper titleContainer authorNameContainer |

	ratingPicker := self newSingleModelPickerNamed: 'Rating'.
	titleContainer := self newContainerControllerNamed: 'Title'.
	authorNameContainer := self newContainerControllerNamed: 'Author Name'.
	creator := (GenericModelCreatorBuilder named: 'Paper' building: StardustPaper accessedOnlyUsing: #(title authorName)) titled: titleContainer authoredBy: authorNameContainer rated: ratingPicker.

	ratingPicker allowAnyOf: #(1 2 3 4 5).

	self assertModelCreationFailedFor: creator.

	ratingPicker updateModelInViewsConsidering: 5.
	creator updateModelInViewsConsidering: (StardustPaper titled: 'Computing Machinery and Intelligence' authoredBy: 'Alan Turing' rated: 3).

	paper := self modelAssembledBy: creator.

	self
		assert: paper title equals: 'Computing Machinery and Intelligence';
		assert: paper authorName equals: 'Alan Turing';
		assert: paper rating equals: 5.

	self
		assertModelAssembledBy: ratingPicker equals: 5;
		assertModelAssembledBy: titleContainer equals: 'Computing Machinery and Intelligence';
		assertModelAssembledBy: authorNameContainer equals: 'Alan Turing'
]

{ #category : #tests }
GenericModelCreatorTest >> testModelCreation [

	| creator paper |

	creator := (GenericModelCreatorBuilder named: 'Paper' building: StardustPaper accessedUsing: #(title authorName rating))
		titled: (self newFixedCreatorFor: 'Computing Machinery and Intelligence')
		authoredBy: (self newFixedCreatorFor: 'Alan Turing')
		rated: (self newFixedCreatorFor: 5).

	paper := self modelAssembledBy: creator.

	self
		assert: paper title equals: 'Computing Machinery and Intelligence';
		assert: paper authorName equals: 'Alan Turing';
		assert: paper rating equals: 5
]

{ #category : #tests }
GenericModelCreatorTest >> testModelCreationFailed [

	| creator |

	creator := (GenericModelCreatorBuilder named: 'Paper' building: StardustPaper accessedUsing: #(title authorName rating))
		titled: (self newFixedCreatorFor: '')
		authoredBy: (self newFixedCreatorFor: 'Alan Turing')
		rated: (self newFixedCreatorFor: 5).

	self assertModelCreationFailedFor: creator
]

{ #category : #tests }
GenericModelCreatorTest >> testModelCreationFailedForChildCreator [

	| creator |

	creator := (GenericModelCreatorBuilder named: 'Paper' building: StardustPaper accessedUsing: #(title authorName rating))
		titled: (self newFixedCreatorFor: 'Computing Machinery and Intelligence')
		authoredBy: (self newSingleModelPickerNamed: 'Author')
		rated: (self newFixedCreatorFor: 5).

	self assertModelCreationFailedFor: creator
]
