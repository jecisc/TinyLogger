Class {
	#name : #TinyStdoutLogger,
	#superclass : #TinyConcreteLogger,
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
