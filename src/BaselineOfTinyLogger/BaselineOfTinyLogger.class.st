"
Description
--------------------

I am a baseline to configure the Tiny logger project.

https://github.com/jecisc/TinyLogger
"
Class {
	#name : #BaselineOfTinyLogger,
	#superclass : #BaselineOf,
	#category : #BaselineOfTinyLogger
}

{ #category : #baselines }
BaselineOfTinyLogger >> baseline: spec [
	<baseline>
	spec for: #common do: [ spec package: 'TinyLogger' ]
]
