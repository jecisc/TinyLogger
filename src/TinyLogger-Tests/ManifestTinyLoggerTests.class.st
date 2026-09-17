"
I contains tests of the implementation of a simple and tiny logger.

I implement different kind of loggers such as:
- Transcript
- Stdout 
- File 

Check the class comment of `TinyLogger` or the documentation present on https://github.com/jecisc/TinyLogger repository for more informations.
"
Class {
	#name : 'ManifestTinyLoggerTests',
	#superclass : 'PackageManifest',
	#category : 'TinyLogger-Tests-Manifest',
	#package : 'TinyLogger-Tests',
	#tag : 'Manifest'
}

{ #category : 'formatting' }
ManifestTinyLoggerTests class >> formatter [

	^ EFFormatter new installNewContext: (EFContext new maxLineLength: 130)
]
