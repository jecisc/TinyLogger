Class {
	#name : #TinyTranscriptLogger,
	#superclass : #TinyConcreteLogger,
	#category : #'TinyLogger-Core'
}

{ #category : #logging }
TinyTranscriptLogger >> record: aString [
	Transcript log: (String streamContents: [ :s | self record: aString on: s ])
]
