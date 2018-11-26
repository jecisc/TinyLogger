"
A TinyStdoutLoggerTest is a test class for testing the behavior of TinyStdoutLogger
"
Class {
	#name : #TinyStdoutLoggerTest,
	#superclass : #TinyConcreteLoggerTest,
	#category : #'TinyLogger-Tests-Core'
}

{ #category : #helpers }
TinyStdoutLoggerTest >> actualClass [
	^ TinyStdoutLogger
]

{ #category : #test }
TinyStdoutLoggerTest >> testRecord [
	| stream |
	stream := '' writeStream.
	[ Stdio stub stdout willReturn: stream.
	logger record: 'This is a test'.
	self assert: (stream contents asString lines last includesSubstring: 'This is a test') ]
		ensure: [ Stdio recoverFromGHMutation.
			stream close ]
]
