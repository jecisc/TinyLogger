Class {
	#name : #TinyLogger,
	#superclass : #TinyAbstractLogger,
	#instVars : [
		'timestampFormatBlock',
		'depth',
		'loggersMap'
	],
	#classVars : [
		'Default'
	],
	#category : #'TinyLogger-Core'
}

{ #category : #accessing }
TinyLogger class >> default [
	^ Default ifNil: [ Default := self new ]
]

{ #category : #accessing }
TinyLogger class >> default: anObject [
	Default := anObject
]

{ #category : #initialization }
TinyLogger class >> reset [
	^ self default: nil
]

{ #category : #'public API' }
TinyLogger >> addFileLogger [
	"Since no file name is passed as parameter, I will log in a file named `TinyLogger.log` next to the image."

	self addLogger: (TinyFileLogger for: self)
]

{ #category : #'public API' }
TinyLogger >> addFileLoggerNamed: aString [
	self addLogger: (TinyFileLogger for: self named: aString)
]

{ #category : #'public API' }
TinyLogger >> addLogger: aLogger [
	(self loggersMap at: aLogger kind ifAbsentPut: [ OrderedCollection new ]) add: aLogger
]

{ #category : #'public API' }
TinyLogger >> addStdoutLogger [
	self addLogger: (TinyStdoutLogger for: self)
]

{ #category : #'public API' }
TinyLogger >> addTranscriptLogger [
	self addLogger: (TinyTranscriptLogger for: self)
]

{ #category : #nesting }
TinyLogger >> decreaseDepthLevel [
	self depth: self depth - 1
]

{ #category : #accessing }
TinyLogger >> defaultTimestampFormatBlock [
	^ [ :aStream | 
	Date today printOn: aStream.
	aStream << ' '.	"Cannot use #space because Stdio streams does not implements it."
	Time now print24: true on: aStream ]
]

{ #category : #accessing }
TinyLogger >> depth [
	^ depth
]

{ #category : #accessing }
TinyLogger >> depth: anObject [
	depth := anObject
]

{ #category : #'public API' }
TinyLogger >> execute: aBlock recordedAs: aString [
	self increaseDepthLevel.
	self record: 'Begin: ' , aString.
	self increaseDepthLevel.
	aBlock cull: aString.
	self decreaseDepthLevel.
	self record: 'End: ' , aString.
	self decreaseDepthLevel
]

{ #category : #'accessing - loggers' }
TinyLogger >> fileLoggers [
	^ self loggersMap at: TinyFileLogger kind ifAbsentPut: [ OrderedCollection new ]
]

{ #category : #nesting }
TinyLogger >> increaseDepthLevel [
	self depth: self depth + 1
]

{ #category : #initialization }
TinyLogger >> initialize [
	super initialize.
	self depth: 0.
	self timestampFormatBlock: self defaultTimestampFormatBlock.
	self loggersMap: Dictionary new
]

{ #category : #accessing }
TinyLogger >> loggers [
	"Since the loggers variable contains a dictionary of loggers, here we faltten the dictonary."

	^ self loggersMap values flatCollect: #yourself
]

{ #category : #accessing }
TinyLogger >> loggersMap [
	^ loggersMap
]

{ #category : #accessing }
TinyLogger >> loggersMap: anObject [
	loggersMap := anObject
]

{ #category : #'public API' }
TinyLogger >> record: aString [
	self loggers do: [ :each | each record: aString ]
]

{ #category : #'public API' }
TinyLogger >> removeAllLoggers [
	self loggers do: [ :each | self removeLogger: each ]
]

{ #category : #'public API' }
TinyLogger >> removeFileLoggers [
	self fileLoggers removeAll
]

{ #category : #'public API' }
TinyLogger >> removeLogger: aLogger [
	(self loggersMap at: aLogger kind ifAbsentPut: [ OrderedCollection new ]) remove: aLogger
]

{ #category : #'public API' }
TinyLogger >> removeStdoutLoggers [
	self stdoutLoggers removeAll
]

{ #category : #'public API' }
TinyLogger >> removeTranscriptLoggers [
	self transcriptLoggers removeAll
]

{ #category : #'accessing - loggers' }
TinyLogger >> stdoutLoggers [
	^ self loggersMap at: TinyStdoutLogger kind ifAbsentPut: [ OrderedCollection new ]
]

{ #category : #accessing }
TinyLogger >> timestampFormatBlock [
	^ timestampFormatBlock
]

{ #category : #accessing }
TinyLogger >> timestampFormatBlock: anObject [
	timestampFormatBlock := anObject
]

{ #category : #'accessing - loggers' }
TinyLogger >> transcriptLoggers [
	^ self loggersMap at: TinyTranscriptLogger kind ifAbsentPut: [ OrderedCollection new ]
]

{ #category : #'public API' }
TinyLogger >> withDefaultLoggers [
	self
		removeAllLoggers;
		addTranscriptLogger;
		addStdoutLogger;
		addFileLogger
]
