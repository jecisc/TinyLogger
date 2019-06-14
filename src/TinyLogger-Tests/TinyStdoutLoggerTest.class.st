"
A TinyStdoutLoggerTest is a test class for testing the behavior of TinyStdoutLogger
"
Class {
	#name : #TinyStdoutLoggerTest,
	#superclass : #TinyLeafLoggerTest,
	#category : #'TinyLogger-Tests-Core'
}

{ #category : #helpers }
TinyStdoutLoggerTest >> actualClass [
	^ TinyStdoutLogger
]

{ #category : #test }
TinyStdoutLoggerTest >> testClearLogger [
	"Do nothing because stdio cannot be clear"
]

{ #category : #test }
TinyStdoutLoggerTest >> testRecord [
	| stream |
	self skipInPharo6.
	stream := '' writeStream.
	[ Stdio stub stdout willReturn: stream.
	logger record: 'This is a test'.
	self assert: (stream contents asString lines last includesSubstring: 'This is a test') ]
		ensure: [ Stdio recoverFromGHMutation.
			stream close ]
]
