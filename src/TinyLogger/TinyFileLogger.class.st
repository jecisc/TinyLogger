"
Description
--------------------

I am a logger that will log the informations in a file on the file system.

I am configured with a file name. If no file name is given to me, I'll use `TinyLogger.log` by default.

I should not be used directly but via a `TinyLogger`.

Examples
--------------------

	(TinyFileLogger for: aTinyLogger) record: 'First log'.
	
	(TinyFileLogger for: aTinyLogger named: 'anotherFile.log') record: 'First log'.	
 
Internal Representation and Key Implementation Points.
--------------------

    Instance Variables
	fileName:		<aString> 	Name of the file in which informations should be logged.

"
Class {
	#name : 'TinyFileLogger',
	#superclass : 'TinyLeafLogger',
	#instVars : [
		'fileName'
	],
	#category : 'TinyLogger-Core',
	#package : 'TinyLogger',
	#tag : 'Core'
}

{ #category : 'accessing' }
TinyFileLogger class >> defaultFileName [
	^ 'TinyLogger.log'
]

{ #category : 'instance creation' }
TinyFileLogger class >> for: aLogger named: aString [
	^ (self for: aLogger)
		fileName: aString;
		yourself
]

{ #category : 'accessing' }
TinyFileLogger class >> kind [
	<ignoreForCoverage>
	^ 'file'
]

{ #category : 'instance creation' }
TinyFileLogger class >> named: aString [
	^ self new
		fileName: aString;
		yourself
]

{ #category : 'logging' }
TinyFileLogger >> clearLog [
	self fileReference ensureDelete
]

{ #category : 'accessing' }
TinyFileLogger >> defaultFileName [
	^ self class defaultFileName
]

{ #category : 'accessing' }
TinyFileLogger >> fileName [
	^ fileName ifNil: [ fileName := self defaultFileName ]
]

{ #category : 'accessing' }
TinyFileLogger >> fileName: anObject [
	fileName := anObject
]

{ #category : 'accessing' }
TinyFileLogger >> fileReference [
	^ self fileName asFileReference
]

{ #category : 'accessing' }
TinyFileLogger >> fileStreamDo: aBlock [
	"For now we re-open the file all the time to avoid problems when we change its image of computer/OS or if the user delete the file. Maybe later we can find a better solution but in any case we should test such weird behaviors."

	self fileReference
		ensureCreateFile;
		writeStreamDo: [ :s | 
			s setToEnd.
			aBlock value: s ]
]

{ #category : 'opening' }
TinyFileLogger >> open [
	TinyOpenTerminalVisitor openTerminalForFileLogger: self
]

{ #category : 'logging' }
TinyFileLogger >> record: aString [
	self fileStreamDo: [ :aStream | self record: aString on: aStream ]
]
