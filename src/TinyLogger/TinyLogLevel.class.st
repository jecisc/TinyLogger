"
Description
--------------------

I represent one logging severity used by `TinyLogger`.
Use my subclasses to select a level, for example `TinyWarnLevel`. A logger configured with a level records events at that level and all more severe levels.
The standard levels are, from least to most severe: `TRACE`, `DEBUG`, `INFO`, `WARN`, `ERROR`, and `FATAL`. `OFF` disables all logging.
"
Class {
	#name : 'TinyLogLevel',
	#superclass : 'Object',
	#category : 'TinyLogger-Core',
	#package : 'TinyLogger',
	#tag : 'Core'
}

{ #category : 'testing' }
TinyLogLevel class >> allows: aTinyLogLevel [
	^ self isOff not and: [ aTinyLogLevel isOff not and: [ aTinyLogLevel priority >= self priority ] ]
]

{ #category : 'testing' }
TinyLogLevel class >> isOff [
	^ false
]

{ #category : 'testing' }
TinyLogLevel class >> priority [
	self subclassResponsibility
]

{ #category : 'testing' }
TinyLogLevel class >> severity [
	self subclassResponsibility
]
