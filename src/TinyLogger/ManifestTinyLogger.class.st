"
I contains the implementation of a simple and tiny logger.

I implement different kind of loggers such as:
- Transcript
- Stdout 
- File 

Check the class comment of `TinyLogger` or the documentation present on https://github.com/jecisc/TinyLogger repository for more informations.
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
