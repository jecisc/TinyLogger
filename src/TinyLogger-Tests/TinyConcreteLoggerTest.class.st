"
A TinyConcreteLoggerTest is a test class for testing the behavior of TinyConcreteLogger
"
Class {
	#name : #TinyConcreteLoggerTest,
	#superclass : #TinyAbstractLoggerTest,
	#instVars : [
		'parentLogger'
	],
	#category : #'TinyLogger-Tests-Core'
}

{ #category : #testing }
TinyConcreteLoggerTest class >> isAbstract [
	^ self = TinyConcreteLoggerTest
]

{ #category : #running }
TinyConcreteLoggerTest >> setUp [
	super setUp.
	parentLogger := TinyLogger new.
	logger := self actualClass for: parentLogger
]

{ #category : #test }
TinyConcreteLoggerTest >> testRecordPreambleOn [
	parentLogger timestampFormatBlock: [ :s | s << 'this is a test' ].
	self assert: (String streamContents: [ :s | logger recordPreambleOn: s]) equals: 'this is a test : '.
	parentLogger timestampFormatBlock: [ :s | s << 'this is a test2' ].
	self assert: (String streamContents: [ :s | logger recordPreambleOn: s]) equals: 'this is a test2 : '
]
