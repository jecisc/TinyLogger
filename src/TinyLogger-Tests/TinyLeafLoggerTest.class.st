"
A TinyConcreteLoggerTest is a test class for testing the behavior of TinyConcreteLogger
"
Class {
	#name : 'TinyLeafLoggerTest',
	#superclass : 'TinyAbstractLoggerTest',
	#instVars : [
		'parentLogger'
	],
	#category : 'TinyLogger-Tests-Core',
	#package : 'TinyLogger-Tests',
	#tag : 'Core'
}

{ #category : 'testing' }
TinyLeafLoggerTest class >> isAbstract [
	^ self = TinyLeafLoggerTest
]

{ #category : 'running' }
TinyLeafLoggerTest >> setUp [
	super setUp.
	parentLogger := TinyLogger new.
	logger := self actualClass for: parentLogger
]

{ #category : 'test' }
TinyLeafLoggerTest >> testRecordPreambleOn [
	parentLogger timestampFormatBlock: [ :s | s << 'this is a test' ].
	self assert: (String streamContents: [ :s | logger recordPreambleOn: s]) equals: 'this is a test : '.
	parentLogger timestampFormatBlock: [ :s | s << 'this is a test2' ].
	self assert: (String streamContents: [ :s | logger recordPreambleOn: s]) equals: 'this is a test2 : '
]
