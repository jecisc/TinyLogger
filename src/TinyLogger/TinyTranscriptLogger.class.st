Class {
	#name : #TinyTranscriptLogger,
	#superclass : #TinyConcreteLogger,
	#category : #'TinyLogger-Core'
}

{ #category : #logging }
TinyTranscriptLogger >> crRecord: aString [
	Transcript crLog: (String streamContents: [ :s | self record: aString on: s ])
]

{ #category : #logging }
TinyTranscriptLogger >> record: aString [
	Transcript log: (String streamContents: [ :s | self record: aString on: s ])
]

{ #category : #logging }
TinyTranscriptLogger >> recordCr: aString [
	Transcript logCr: (String streamContents: [ :s | self record: aString on: s ])
]
