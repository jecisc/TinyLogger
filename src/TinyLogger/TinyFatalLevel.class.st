"
Description
--------------------

I represent the `FATAL` logging severity.
"
Class {
	#name : 'TinyFatalLevel',
	#superclass : 'TinyLogLevel',
	#category : 'TinyLogger-Core',
	#package : 'TinyLogger',
	#tag : 'Core'
}

{ #category : 'testing' }
TinyFatalLevel class >> priority [
	^ 600
]

{ #category : 'testing' }
TinyFatalLevel class >> severity [
	^ 'FATAL'
]
