"
Description
--------------------

I represent the special `OFF` logging severity, which disables all standard logging levels.
"
Class {
	#name : 'TinyOffLevel',
	#superclass : 'TinyLogLevel',
	#category : 'TinyLogger-Core',
	#package : 'TinyLogger',
	#tag : 'Core'
}

{ #category : 'testing' }
TinyOffLevel class >> isOff [
	^ true
]

{ #category : 'testing' }
TinyOffLevel class >> priority [
	^ 700
]

{ #category : 'testing' }
TinyOffLevel class >> severity [
	^ 'OFF'
]
