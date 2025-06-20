"
Description
--------------------

I am an abstract class that should be subclasses by the concrete loggers of the project. Each of my subclass represent a different way to log an information (in a file, transcript, stdout...).

Users should not use me or my subclasses directly. The user should manage logging via `TinyLogger` which is a composite of my subclasses.

Public API and Key Messages
--------------------

- #record: 	Record a string as parameter
	
 
Internal Representation and Key Implementation Points.
--------------------

    Instance Variables
	parentLogger:		<aTinyLogger>	As said before the user should use my subclasses via a `TinyLogger` composite. My parent logger is this `TinyLogger` instance.

"
Class {
	#name : 'TinyLeafLogger',
	#superclass : 'TinyAbstractLogger',
	#instVars : [
		'parentLogger'
	],
	#category : 'TinyLogger-Core',
	#package : 'TinyLogger',
	#tag : 'Core'
}

{ #category : 'instance creation' }
TinyLeafLogger class >> for: aTinyLogger [

	^ self new
		  parentLogger: aTinyLogger;
		  in: [ :logger | aTinyLogger addLogger: logger ];
		  yourself
]

{ #category : 'testing' }
TinyLeafLogger class >> isAbstract [
	<ignoreForCoverage>
	^ self = TinyLeafLogger
]

{ #category : 'accessing' }
TinyLeafLogger class >> kind [
	<ignoreForCoverage>
	^ self subclassResponsibility
]

{ #category : 'accessing' }
TinyLeafLogger >> depth [
	^ self parentLogger depth
]

{ #category : 'accessing' }
TinyLeafLogger >> indentExecutionBlock [

	^ self parentLogger indentExecutionBlock
]

{ #category : 'accessing' }
TinyLeafLogger >> indentationString [

	^ self parentLogger indentationString
]

{ #category : 'accessing' }
TinyLeafLogger >> kind [
	^ self class kind
]

{ #category : 'logging' }
TinyLeafLogger >> newLine [
	^ OSPlatform current lineEnding
]

{ #category : 'opening' }
TinyLeafLogger >> open [
	self subclassResponsibility
]

{ #category : 'accessing' }
TinyLeafLogger >> parentLogger [
	^ parentLogger
]

{ #category : 'accessing' }
TinyLeafLogger >> parentLogger: aLogger [
	parentLogger := aLogger
]

{ #category : 'logging' }
TinyLeafLogger >> record: aString on: aStream [
	self recordPreambleOn: aStream.
	aStream << aString << self newLine
]

{ #category : 'accessing' }
TinyLeafLogger >> recordPreambleOn: aStream [

	<compilerOptions: #( #+ optionInlineTimesRepeat )>
	self recordTimestampOn: aStream.
	aStream << ': '.
	self depth timesRepeat: [ aStream nextPutAll: self indentationString ]
]

{ #category : 'accessing' }
TinyLeafLogger >> recordTimestampOn: aStream [

	self timestampFormatBlock cull: aStream cull: DateAndTime now
]

{ #category : 'accessing' }
TinyLeafLogger >> timestampFormatBlock [
	^ self parentLogger timestampFormatBlock
]
