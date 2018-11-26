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
	logger record: 'This is a test'.
	self assert: (Stdio stdout contents asString lines last includesSubstring: 'This is a test')
]
