"
Description
--------------------

I represent the `WARN` logging severity.
"
Class {
	#name : 'TinyWarnLevel',
	#superclass : 'TinyLogLevel',
	#category : 'TinyLogger-Core',
	#package : 'TinyLogger',
	#tag : 'Core'
}

{ #category : 'testing' }
TinyWarnLevel class >> priority [
	^ 400
]

{ #category : 'testing' }
TinyWarnLevel class >> severity [
	^ 'WARN'
]
