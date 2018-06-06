"
I'm used in tests
"
Class {
	#name : #StardustPaper,
	#superclass : #Object,
	#instVars : [
		'authorName',
		'title',
		'rating'
	],
	#category : #'Stardust-Tests-Support'
}

{ #category : #'instance creation' }
StardustPaper class >> titled: aTitle authoredBy: anAuthorName rated: aRanking [

	AssertionCheckerBuilder new
		raising: InstanceCreationFailed;
		checking: [ :asserter | 
			asserter
				enforce: [ aTitle notEmpty ] because: 'A paper must have a title.';
				enforce: [ anAuthorName notEmpty and: [ anAuthorName first isUppercase ] ] because: 'The author name must be a proper name.';
				enforce: [ aRanking between: 1 and: 5 ] because: 'The ranking must be between 1 and 5.' ];
		buildAndCheck.
		
	^ self new initializeTitled: aTitle authoredBy: anAuthorName rated: aRanking
]

{ #category : #accessing }
StardustPaper >> authorName [
	^ authorName
]

{ #category : #initialization }
StardustPaper >> initializeTitled: aTitle authoredBy: anAuthorName rated: aRanking [

	title := aTitle.
	authorName := anAuthorName.
	rating := aRanking
]

{ #category : #accessing }
StardustPaper >> rating [
	^ rating
]

{ #category : #accessing }
StardustPaper >> title [

	^ title
]
