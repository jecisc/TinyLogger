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
	spec
		for: #common
		do: [
			"Packages"
			spec
				package: 'TinyLogger';
				package: 'TinyLogger-Tests' with: [ spec requires: #('TinyLogger') ].
			
			"Groups"
			spec
				group: 'Core' with: #('TinyLogger');
				group: 'Tests' with: #('TinyLogger-Tests') ]
]