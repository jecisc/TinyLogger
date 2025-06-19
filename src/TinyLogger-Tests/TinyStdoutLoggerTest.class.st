"
A TinyStdoutLoggerTest is a test class for testing the behavior of TinyStdoutLogger
"
Class {
	#name : 'TinyStdoutLoggerTest',
	#superclass : 'TinyLeafLoggerTest',
	#category : 'TinyLogger-Tests-Core',
	#package : 'TinyLogger-Tests',
	#tag : 'Core'
}

{ #category : 'helpers' }
TinyStdoutLoggerTest >> actualClass [
	^ TinyStdoutLogger
]

{ #category : 'tests' }
TinyStdoutLoggerTest >> testClearLog [
	self shouldnt: [ logger clearLog ] raise: Error
]

{ #category : 'tests' }
TinyStdoutLoggerTest >> testIndentationString [

	| stream |
	stream := '' writeStream.
	[
		Stdio stub stdout willReturn: stream.
		parentLogger indentationString: '--'.
		logger execute: [ logger record: 'This is a test' ] recordedAs: 'block'.
		self assert: (stream contents asString lines second includesSubstring: '--This is a test') ] ensure: [
			Stdio recoverFromGHMutation.
			stream close ]
]

{ #category : 'tests' }
TinyStdoutLoggerTest >> testRecord [
	| stream |
	stream := '' writeStream.
	[ Stdio stub stdout willReturn: stream.
	logger record: 'This is a test'.
	self assert: (stream contents asString lines last includesSubstring: 'This is a test') ]
		ensure: [ Stdio recoverFromGHMutation.
			stream close ]
]
