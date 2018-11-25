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

{ #category : #'code-critics' }
ManifestTinyLogger class >> ruleRBCollectionMessagesToExternalObjectRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#TinyLogger #addLogger: #false)) #'2018-11-25T20:54:01.067573+01:00') #(#(#RGMethodDefinition #(#TinyLogger #removeLogger: #false)) #'2018-11-25T20:54:59.231573+01:00') )
]
