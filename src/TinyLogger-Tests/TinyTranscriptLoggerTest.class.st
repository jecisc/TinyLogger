Class {
	#name : #TinyTranscriptLoggerTest,
	#superclass : #TinyConcreteLoggerTest,
	#category : #'TinyLogger-Tests-Core'
}

{ #category : #helpers }
TinyTranscriptLoggerTest >> actualClass [
	^ TinyTranscriptLogger
]

{ #category : #test }
TinyTranscriptLoggerTest >> testRecord [
	logger record: 'This is a test'.
	Transcript stepGlobal.
	self assert: (Transcript contents asString lines last includesSubstring: 'This is a test')
]
