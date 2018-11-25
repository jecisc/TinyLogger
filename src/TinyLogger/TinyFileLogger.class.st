Class {
	#name : #TinyFileLogger,
	#superclass : #TinyConcreteLogger,
	#instVars : [
		'fileName'
	],
	#category : #'TinyLogger-Core'
}

{ #category : #logging }
TinyFileLogger >> crRecord: aString [
	self fileStreamDo: [ :aStream | self crRecord: aString on: aStream ]
]

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
	"For now we re-open the file all the time to avoid problems when we change its image of computer/OS or if the user delete the file. Maybe later we can find a better solution but in any case we should test such weird behaviors."

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

{ #category : #logging }
TinyFileLogger >> recordCr: aString [
	self fileStreamDo: [ :aStream | self recordCr: aString on: aStream ]
]
