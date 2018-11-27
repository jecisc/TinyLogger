Class {
	#name : #TinyTranscriptLogger,
	#superclass : #TinyLeafLogger,
	#category : #'TinyLogger-Core'
}

{ #category : #accessing }
TinyTranscriptLogger class >> kind [
	^ 'transcript'
]

{ #category : #logging }
TinyTranscriptLogger >> record: aString [
	Transcript log: (String streamContents: [ :s | self record: aString on: s ])
]
