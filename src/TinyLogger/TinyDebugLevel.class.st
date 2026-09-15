"
Description
--------------------

I represent the `DEBUG` logging severity.
"
Class {
	#name : 'TinyDebugLevel',
	#superclass : 'TinyLogLevel',
	#category : 'TinyLogger-Core',
	#package : 'TinyLogger',
	#tag : 'Core'
}

{ #category : 'testing' }
TinyDebugLevel class >> priority [
	^ 200
]

{ #category : 'testing' }
TinyDebugLevel class >> severity [
	^ 'DEBUG'
]
