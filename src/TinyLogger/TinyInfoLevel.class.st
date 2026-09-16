"
Description
--------------------

I represent the `INFO` logging severity.
"
Class {
	#name : 'TinyInfoLevel',
	#superclass : 'TinyLogLevel',
	#category : 'TinyLogger-Core',
	#package : 'TinyLogger',
	#tag : 'Core'
}

{ #category : 'testing' }
TinyInfoLevel class >> priority [
	^ 300
]

{ #category : 'testing' }
TinyInfoLevel class >> severity [
	^ 'INFO'
]
