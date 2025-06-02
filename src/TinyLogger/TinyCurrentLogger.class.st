"
Description
--------------------

I am a dynamic variable defining the current `TinyLogger` to use to record events.

Examples
--------------------

	TinyCurrentLogger value: (TinyLogger new addTranscriptLogger; yourself) during: [ 
		'test' record.
		TinyCurrentLogger value record: 'Test2'
	]
"
Class {
	#name : 'TinyCurrentLogger',
	#superclass : 'DynamicVariable',
	#category : 'TinyLogger-Core',
	#package : 'TinyLogger',
	#tag : 'Core'
}

{ #category : 'accessing' }
TinyCurrentLogger >> default [
	^ TinyLogger default
]
