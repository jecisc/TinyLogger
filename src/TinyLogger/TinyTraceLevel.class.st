"
Description
--------------------

I represent the `TRACE` logging severity.
"
Class {
	#name : 'TinyTraceLevel',
	#superclass : 'TinyLogLevel',
	#category : 'TinyLogger-Core',
	#package : 'TinyLogger',
	#tag : 'Core'
}

{ #category : 'testing' }
TinyTraceLevel class >> priority [
	^ 100
]

{ #category : 'testing' }
TinyTraceLevel class >> severity [
	^ 'TRACE'
]
