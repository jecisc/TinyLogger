"
Description
--------------------

I am an abstract class that should be subclasses by the concrete loggers of the project. Each of my subclass represent a different way to log an information (in a file, transcript, stdout...).

Users should not use me or my subclasses directly. The user should manage logging via `TinyLogger` which is a composite of my subclasses.

Public API and Key Messages
--------------------

- #record: 	Record an unlevelled string as parameter
- #record:atLevel:	Record a levelled string. Built-in leaf loggers use #record:on:atLevel: to add the parent logger's configurable level prefix.
	
 
Internal Representation and Key Implementation Points.
--------------------

    Instance Variables
	parentLogger:		<aTinyLogger>	As said before the user should use my subclasses via a `TinyLogger` composite. My parent logger is this `TinyLogger` instance.

Custom leaf loggers remain source-compatible: the inherited #record:atLevel: falls back to #record:. Implement #record:atLevel: and use #record:on:atLevel: when the custom output should include level markup.
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

{ #category : 'accessing' }
TinyLeafLogger >> levelPrefixBlock [
	^ self parentLogger levelPrefixBlock
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
TinyLeafLogger >> record: aString atLevel: aTinyLogLevel [
	self record: aString
]

{ #category : 'logging' }
TinyLeafLogger >> record: aString on: aStream [
	self recordPreambleOn: aStream.
	aStream << aString << self newLine
]

{ #category : 'logging' }
TinyLeafLogger >> record: aString on: aStream atLevel: aTinyLogLevel [
	self recordPreambleOn: aStream atLevel: aTinyLogLevel.
	aStream << aString << self newLine
]

{ #category : 'accessing' }
TinyLeafLogger >> recordIndentationOn: aStream [
	<compilerOptions: #( #+ optionInlineTimesRepeat )>
	self depth timesRepeat: [ aStream nextPutAll: self indentationString ]
]

{ #category : 'accessing' }
TinyLeafLogger >> recordLevelPrefixOn: aStream atLevel: aTinyLogLevel [
	self levelPrefixBlock cull: aStream cull: aTinyLogLevel
]

{ #category : 'accessing' }
TinyLeafLogger >> recordPreambleBeginningOn: aStream [
	self recordTimestampOn: aStream.
	aStream << ': '
]

{ #category : 'accessing' }
TinyLeafLogger >> recordPreambleOn: aStream [
	self recordPreambleBeginningOn: aStream.
	self recordIndentationOn: aStream
]

{ #category : 'accessing' }
TinyLeafLogger >> recordPreambleOn: aStream atLevel: aTinyLogLevel [
	self recordPreambleBeginningOn: aStream.
	self recordLevelPrefixOn: aStream atLevel: aTinyLogLevel.
	self recordIndentationOn: aStream
]

{ #category : 'accessing' }
TinyLeafLogger >> recordTimestampOn: aStream [
	self timestampFormatBlock cull: aStream cull: DateAndTime now
]

{ #category : 'accessing' }
TinyLeafLogger >> timestampFormatBlock [
	^ self parentLogger timestampFormatBlock
]
