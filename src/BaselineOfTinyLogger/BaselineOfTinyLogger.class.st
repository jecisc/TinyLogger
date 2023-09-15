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
			"Dependencies"
			self mocketry: spec.
			
			"Packages"
			spec
				package: 'TinyLogger';
				package: 'TinyLogger-Tests' with: [ spec requires: #('TinyLogger' 'Mocketry') ].
			
			"Groups"
			spec
				group: 'Core' with: #('TinyLogger');
				group: 'Tests' with: #('TinyLogger-Tests') ]
]

{ #category : #dependencies }
BaselineOfTinyLogger >> mocketry: spec [
	spec
		baseline: 'Mocketry'
		with: [ spec
				loads: #('Core');
				repository: 'github://dionisiydk/Mocketry:v7.0.x' ]
]
