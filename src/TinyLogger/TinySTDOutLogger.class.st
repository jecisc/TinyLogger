Class {
	#name : #TinySTDOutLogger,
	#superclass : #TinyConcreteLogger,
	#category : #'TinyLogger-Core'
}

{ #category : #logging }
TinySTDOutLogger >> crRecord: aString [
	self crRecord: aString on: Stdio stdout 
]

{ #category : #logging }
TinySTDOutLogger >> record: aString [
	self record: aString on: Stdio stdout 
]

{ #category : #logging }
TinySTDOutLogger >> recordCr: aString [
	self recordCr: aString on: Stdio stdout 
]
