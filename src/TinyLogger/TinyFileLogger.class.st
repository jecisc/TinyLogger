Class {
	#name : #TinyFileLogger,
	#superclass : #TinyConcreteLogger,
	#instVars : [
		'fileName'
	],
	#category : #'TinyLogger-Core'
}

{ #category : #accessing }
TinyFileLogger >> fileName [
	^ fileName
]

{ #category : #accessing }
TinyFileLogger >> fileName: anObject [
	fileName := anObject
]

{ #category : #accessing }
TinyFileLogger >> fileStreamDo: aBlock [
	^ self fileName asFileReference
		ensureCreateFile;
		writeStreamDo: [ :s | 
			s setToEnd.
			aBlock value: s ]
]

{ #category : #accessing }
TinyFileLogger >> parentLogger: aTinyLogger [
	super parentLogger: aTinyLogger.
	self fileName: aTinyLogger defaultFileName
]

{ #category : #logging }
TinyFileLogger >> record: aString [
	self fileStreamDo: [ :aStream | self record: aString on: aStream ]
]
