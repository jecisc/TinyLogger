"
Description
--------------------

I am a logger that will log the informations in the StdOut.

I should not be used directly but via a `TinyLogger`.

Examples
--------------------

	(TinyStdoutLogger for: aTinyLogger) record: 'First log'
"
Class {
	#name : #TinyStdoutLogger,
	#superclass : #TinyLeafLogger,
	#category : #'TinyLogger-Core'
}

{ #category : #accessing }
TinyStdoutLogger class >> kind [
	^ 'stdout'
]

{ #category : #logging }
TinyStdoutLogger >> record: aString [
	self record: aString on: Stdio stdout 
]
