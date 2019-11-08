"
Description
--------------------

I am a logger that will log the informations in the Transcript.

I should not be used directly but via a `TinyLogger`.

Examples
--------------------

	(TinyTranscriptLogger for: aTinyLogger) record: 'First log'
"
Class {
	#name : #TinyTranscriptLogger,
	#superclass : #TinyLeafLogger,
	#category : #'TinyLogger-Core'
}

{ #category : #accessing }
TinyTranscriptLogger class >> kind [
	<ignoreForCoverage>
	^ 'transcript'
]

{ #category : #logging }
TinyTranscriptLogger >> clearLog [
	Transcript clear
]

{ #category : #logging }
TinyTranscriptLogger >> record: aString [
	Transcript trace: (String streamContents: [ :s | self record: aString on: s ])
]
