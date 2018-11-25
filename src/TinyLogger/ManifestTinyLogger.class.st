"
I contains the implementation of a simple and tiny logger.

I can either log informations in the Trascript and/or in a file.
"
Class {
	#name : #ManifestTinyLogger,
	#superclass : #PackageManifest,
	#category : #'TinyLogger-Manifest'
}

{ #category : #'code-critics' }
ManifestTinyLogger class >> ruleRBCodeCruftLeftInMethodsRuleV1FalsePositive [
	^ #(#(#(#RGClassDefinition #(#TinyTranscriptLogger)) #'2018-11-25T02:59:41.364573+01:00') )
]
