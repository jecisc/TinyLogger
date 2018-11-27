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
