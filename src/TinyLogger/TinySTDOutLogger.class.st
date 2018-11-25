Class {
	#name : #TinySTDOutLogger,
	#superclass : #TinyConcreteLogger,
	#category : #'TinyLogger-Core'
}

{ #category : #logging }
TinySTDOutLogger >> record: aString [
	self record: aString on: Stdio stdout 
]
