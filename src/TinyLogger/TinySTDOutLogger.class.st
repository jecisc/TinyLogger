Class {
	#name : #TinySTDOutLogger,
	#superclass : #TinyConcreteLogger,
	#category : #'TinyLogger-Core'
}

{ #category : #accessing }
TinySTDOutLogger class >> kind [
	^ 'stdout'
]

{ #category : #logging }
TinySTDOutLogger >> record: aString [
	self record: aString on: Stdio stdout 
]
