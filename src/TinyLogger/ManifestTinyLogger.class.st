"
I contains the implementation of a simple and tiny logger.

I implement different kind of loggers such as:
- Transcript
- Stdout 
- File 

Check the class comment of `TinyLogger` or the documentation present on https://github.com/jecisc/TinyLogger repository for more informations.
"
Class {
	#name : 'ManifestTinyLogger',
	#superclass : 'PackageManifest',
	#category : 'TinyLogger-Manifest',
	#package : 'TinyLogger',
	#tag : 'Manifest'
}

{ #category : 'code-critics' }
ManifestTinyLogger class >> ruleTempsReadBeforeWrittenRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#TinyLogger #execute:recordedAs: #false)) #'2022-06-02T15:28:59.459+02:00') )
]
