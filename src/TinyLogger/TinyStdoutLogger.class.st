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
	#instVars : [
		'streamClassProvider'
	],
	#category : #'TinyLogger-Core'
}

{ #category : #accessing }
TinyStdoutLogger class >> kind [
	^ 'stdout'
]

{ #category : #logging }
TinyStdoutLogger >> clearLogger [
	"We do nothing here since we cannot clear stdout"

	
]

{ #category : #initialization }
TinyStdoutLogger >> initialize [
	super initialize.
	self flag: #pharo6. "This is needed because in Pharo 6.1 Stdio does not works well. When Pharo 7 will be the minimum supported, remove this hack."
	streamClassProvider := SystemVersion current major < 7 ifTrue: [ FileStream ] ifFalse: [ Stdio ]
]

{ #category : #logging }
TinyStdoutLogger >> record: aString [
	self record: aString on: streamClassProvider stdout 
]
