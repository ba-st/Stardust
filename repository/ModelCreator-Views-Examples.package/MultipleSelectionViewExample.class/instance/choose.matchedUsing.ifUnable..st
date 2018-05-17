selection protocol
choose: aCollection matchedUsing: aMatchBlock ifUnable: anUnableBlock

	| matches |

	matches := OrderedCollection new.
	aCollection
		do: [ :elementToMatch | 
			availableElements
				detect: [ :availableElement | aMatchBlock value: elementToMatch value: availableElement ]
				ifFound: [ :matchingElement | matches add: matchingElement ]
				ifNone: [ ^ anUnableBlock value ] ].
	self setChosenElementsTo: matches asArray