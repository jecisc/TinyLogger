"
A TinyAbstractLoggerTest is a test class for testing the behavior of TinyAbstractLogger
"
Class {
	#name : #TinyAbstractLoggerTest,
	#superclass : #TestCase,
	#instVars : [
		'logger'
	],
	#category : #'TinyLogger-Tests-Core'
}

{ #category : #testing }
TinyAbstractLoggerTest class >> isAbstract [
	^ self = TinyAbstractLoggerTest
]

{ #category : #testing }
TinyAbstractLoggerTest class >> shouldInheritSelectors [
	^ true
]

{ #category : #helpers }
TinyAbstractLoggerTest >> actualClass [
	^ self subclassResponsibility
]

{ #category : #test }
TinyAbstractLoggerTest >> testRecord [
	self subclassResponsibility
]
