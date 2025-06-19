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
	#name : 'TinyStdoutLogger',
	#superclass : 'TinyLeafLogger',
	#category : 'TinyLogger-Core',
	#package : 'TinyLogger',
	#tag : 'Core'
}

{ #category : 'accessing' }
TinyStdoutLogger class >> kind [
	<ignoreForCoverage>
	^ 'stdout'
]

{ #category : 'logging' }
TinyStdoutLogger >> clearLog [
	"We do nothing here since we cannot clear stdout"

	
]

{ #category : 'opening' }
TinyStdoutLogger >> open [

	self inform: 'Cannot open STDOut logger.'
]

{ #category : 'logging' }
TinyStdoutLogger >> record: aString [
	| stream |
	stream := Stdio stdout.
	self record: aString on: stream.

	"The flush is needed to send the record in the stdout."
	stream flush
]
