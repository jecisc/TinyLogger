"
A TinyAbstractLoggerTest is a test class for testing the behavior of TinyAbstractLogger
"
Class {
	#name : 'TinyAbstractLoggerTest',
	#superclass : 'TestCase',
	#instVars : [
		'logger'
	],
	#category : 'TinyLogger-Tests-Core',
	#package : 'TinyLogger-Tests',
	#tag : 'Core'
}

{ #category : 'testing' }
TinyAbstractLoggerTest class >> isAbstract [
	^ self = TinyAbstractLoggerTest
]

{ #category : 'testing' }
TinyAbstractLoggerTest class >> shouldInheritSelectors [
	^ true
]

{ #category : 'helpers' }
TinyAbstractLoggerTest >> actualClass [
	^ self subclassResponsibility
]

{ #category : 'helpers' }
TinyAbstractLoggerTest >> skipInPharo6 [
	self flag: #pharo6. "There is a bug with stdout in Pharo 6 and a hack to manage it. But it breaks the tests so we skip the tests using Stdio streams. Remove that when compatibility with P6 will be dropped."
	SystemVersion current major < 7 ifTrue: [ self skip ]
]

{ #category : 'tests' }
TinyAbstractLoggerTest >> testClearLog [
	self subclassResponsibility
]

{ #category : 'tests' }
TinyAbstractLoggerTest >> testIdentationString [
	self subclassResponsibility
]

{ #category : 'tests' }
TinyAbstractLoggerTest >> testRecord [
	self subclassResponsibility
]
