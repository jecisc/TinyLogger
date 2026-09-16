"
Description
--------------------

I represent the `ERROR` logging severity.
"
Class {
	#name : 'TinyErrorLevel',
	#superclass : 'TinyLogLevel',
	#category : 'TinyLogger-Core',
	#package : 'TinyLogger',
	#tag : 'Core'
}

{ #category : 'testing' }
TinyErrorLevel class >> priority [
	^ 500
]

{ #category : 'testing' }
TinyErrorLevel class >> severity [
	^ 'ERROR'
]
