"
I understand methods beginning #assert:... and #deny:... (and my class-side understands #assert:description:).  I am the superclass of TestCase and TestResource and can also be the superclass of any test helper classes you create to factor out test behaviour.  I exist so that test code can be refactored between my subclasses without difficulty.

Send #assert:description: when you want to check for an expected value. For example, you might say
	self assert: socket isOpen description: 'We requested a socket but now it is not open'.
to test whether or not a socket is open at a point in a test.  Use description strings both to give more information about where a test failed in debugger notifiers and logs, and to document the intent of a test.  Other methods include #assert:, #assert:description:resumable:, #deny:, #deny:description:, #deny:description:resumable:, #should:raise:, #should:raise:description:, #shouldnt:raise:, #shouldnt:raise:description:.  All these methods are defined on the superclass, TestAsserter.  (Any convenience assertion methods you create for general use should also be defined in my 'convenience' protocol.)

Override my class-side #isLogging in subclasses to have failed assertion descriptions shown on the Transcript.  To have them appear elsewhere, also override my class-side #failureLog.

"
Class {
	#name : #TestAsserter,
	#superclass : #Object,
	#traits : 'TAssertable - {#executeShould:inScopeOf:withDescriptionContaining:. #skipUnless:}',
	#classTraits : 'TAssertable classTrait',
	#category : #'Stardust-Tests-ModelCreator'
}

{ #category : #asserting }
TestAsserter class >> assert: aBoolean description: aString [
	"Minimal clone of the instance-side assert protocol so that class-side methods can use it."

	aBoolean ifFalse:
		[self logFailure: aString.
		self classForTestResult failure signal: aString].
]

{ #category : #asserting }
TestAsserter class >> classForTestResult [
	"Returns the class of the test result"
	^ TestResult
]

{ #category : #factory }
TestAsserter class >> classForTestSuite [
	^ TestSuite
]

{ #category : #logging }
TestAsserter class >> failureLog [
	^Transcript
]

{ #category : #logging }
TestAsserter class >> isLogging [
	"By default, we're not logging failures. Override in subclasses as desired."

	^false
]

{ #category : #logging }
TestAsserter class >> logFailure: aString [
	self isLogging ifTrue:
		[self failureLog cr; nextPutAll: aString; flush].
]

{ #category : #factory }
TestAsserter class >> methodPassed: aSelector [

	^ false
]

{ #category : #factory }
TestAsserter class >> suiteClass [
	^TestSuite
]

{ #category : #asserting }
TestAsserter >> assert: aBoolean [
	aBoolean ifFalse:
		[self logFailure: 'Assertion failed'.
		self defaultTestFailure signal: 'Assertion failed'].
]

{ #category : #asserting }
TestAsserter >> assert: aBooleanOrBlock description: aStringOrBlock [
	aBooleanOrBlock value ifFalse: [
		| aString |
		aString := aStringOrBlock value.
		self logFailure: aString.
		self classForTestResult failure signal: aString]
			
]

{ #category : #asserting }
TestAsserter >> assert: aBooleanOrBlock description: aStringOrBlock resumable: resumableBoolean [ 
	| exception |
	aBooleanOrBlock value
		ifFalse: 
			[|aString|
			aString := aStringOrBlock value.
			self logFailure: aString.
			exception := resumableBoolean
						ifTrue: [self classForTestResult resumableFailure]
						ifFalse: [self classForTestResult failure].
			exception signal: aString]
			
]

{ #category : #factory }
TestAsserter >> classForTestResource [
	^ TestResource
]

{ #category : #factory }
TestAsserter >> classForTestResult [
	"Returns the class of the test result"
	
	"note that we did not name this method testResultClass because it is considered by tools as a test method."
	^ self class classForTestResult
]

{ #category : #factory }
TestAsserter >> classForTestSuite [
	"Returns the class of the test suite"
	
	"note that we did not name this method testSuiteClass because it is considered by tools as a test method. it could be suiteClass"
	^ self class classForTestSuite
]

{ #category : #private }
TestAsserter >> comparingCollectionBetween: left and: right [
	| additionalLeft additionalRight sortBlock|
	
	"use a very slow sort block"
	sortBlock := [ :a :b | a asString <= b asString ].
	additionalLeft := (left difference: right) sorted: sortBlock.
	additionalRight := (right difference: left) sorted: sortBlock. 
	
	^ String streamContents: [:stream |
		stream
			nextPutAll: 'Given Collections do not match. Got '; lf;
			tab; nextPutAll: 'left := '; print: left; nextPut: $.; lf;
			nextPutAll: ' instead of ';
			tab; nextPutAll: ' right :='; print: right; nextPut: $.; lf.
		left size = right size
			ifFalse: [ 
				stream 
					nextPutAll: 'Collection size does not match: left='; 
					print: left size;
					nextPutAll: ' vs. right=';
					print: right size; lf ].
		additionalLeft isEmpty
			ifFalse: [ 
				stream 
					nextPutAll: 'Got ';
					print: additionalLeft size;
					nextPutAll: ' additional element(s) in the left collection: ';
					tab; print: additionalLeft  ].
		additionalRight isEmpty
			ifFalse: [ 
				stream 
					nextPutAll: 'Got ';
					print: additionalRight size;
					nextPutAll: ' additional element(s) in the right collection: ';
					tab; print: additionalRight  ]]
]

{ #category : #factory }
TestAsserter >> defaultTestError [

	^ self classForTestResult error
]

{ #category : #factory }
TestAsserter >> defaultTestFailure [

	^ self classForTestResult failure
]

{ #category : #logging }
TestAsserter >> logFailure: aString [
	self class logFailure: aString.
]

{ #category : #'*Stardust-Tests-ModelCreator' }
TestAsserter >> should: aBlock raise: anException withDescription: aDescription [

	self
		should: aBlock
		raise: anException
		whoseDescriptionIncludes: aDescription
		description: ('Exception message should be: <1s>' expandMacrosWith: aDescription)
]
