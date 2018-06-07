"
I'm a policy  used in single or multiple pickers. 
My existence is just the consecuence of some constraints in the UI frameworks. By default, you shouldn't worry and use just the default picking policy.
But, for example some UI frameworks only allows you to configure a printSelector, but this message is always sent to the object you put 
in the selection widget and sometimes external context is needed to print-it right.

So, if you have special needs you can subclass-me and implement the required methods:
- pickFrom: will receive the object contained in the UI widget and it's supposed to return the real model object
- is:equalTo: is used to compare the objects contained in the UI widget with the real model object.

Also don't forget to configure the picker with the objects the UI component will support.
"
Class {
	#name : #ModelPickingPolicy,
	#superclass : #Object,
	#category : #Stardust
}

{ #category : #testing }
ModelPickingPolicy >> is: anUIContainedObject equalTo: aModel [

	self subclassResponsibility
]

{ #category : #accessing }
ModelPickingPolicy >> pickFrom: anUIContainedObject [

	self subclassResponsibility
]
