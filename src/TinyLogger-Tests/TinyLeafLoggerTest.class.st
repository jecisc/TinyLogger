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

{ #category : 'private' }
TinyLeafLoggerTest >> performTest [

	TinyCurrentLogger value: parentLogger during: [ super performTest ]
]

{ #category : 'running' }
TinyLeafLoggerTest >> setUp [
	super setUp.
	parentLogger := TinyLogger new.
	logger := self actualClass for: parentLogger
]

{ #category : 'tests' }
TinyLeafLoggerTest >> testRecordPreambleOn [
	parentLogger timestampFormatBlock: [ :s | s << 'this is a test' ].
	self assert: (String streamContents: [ :s | logger recordPreambleOn: s]) equals: 'this is a test: '.
	parentLogger timestampFormatBlock: [ :s | s << 'this is a test2' ].
	self assert: (String streamContents: [ :s | logger recordPreambleOn: s]) equals: 'this is a test2: '
]

{ #category : 'tests' }
TinyLeafLoggerTest >> testRecordTimestampOn [

	parentLogger timestampFormatBlock: [ :s | s << 'this is a test' ].
	self assert: (String streamContents: [ :s | logger recordTimestampOn: s ]) equals: 'this is a test'.
	parentLogger timestampFormatBlock: [ :s | s << 'this is a test2' ].
	self assert: (String streamContents: [ :s | logger recordTimestampOn: s ]) equals: 'this is a test2'
]
