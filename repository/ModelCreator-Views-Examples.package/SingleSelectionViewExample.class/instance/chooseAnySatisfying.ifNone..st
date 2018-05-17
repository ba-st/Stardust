selection protocol
chooseAnySatisfying: aMatchBlock ifNone: aBlock

	availableElements detect: aMatchBlock ifFound: [ :found | self setChosenElementTo: (Optional containing: found) ] ifNone: aBlock