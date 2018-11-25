Class {
	#name : #TinyLogger,
	#superclass : #TinyAbstractLogger,
	#instVars : [
		'timestampFormatBlock',
		'defaultFileName',
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

{ #category : #accessing }
TinyLogger class >> defaultFileName [
	^ 'Application.log'
]

{ #category : #initialization }
TinyLogger class >> reset [
	^ self default: nil
]

{ #category : #'adding/removing' }
TinyLogger >> addFileLogger [
	self addLogger: (TinyFileLogger for: self)
]

{ #category : #'adding/removing' }
TinyLogger >> addFileLoggerNamed: aString [
	self addLogger: (TinyFileLogger for: self named: aString)
]

{ #category : #'adding/removing' }
TinyLogger >> addLogger: aLogger [
	(self loggersMap at: aLogger kind ifAbsentPut: [ OrderedCollection new ]) add: aLogger
]

{ #category : #'adding/removing' }
TinyLogger >> addStdoutLogger [
	self addLogger: (TinySTDOutLogger for: self)
]

{ #category : #'adding/removing' }
TinyLogger >> addTranscriptLogger [
	self addLogger: (TinyTranscriptLogger for: self)
]

{ #category : #nesting }
TinyLogger >> decreaseDepthLevel [
	self depth: self depth - 1
]

{ #category : #accessing }
TinyLogger >> defaultFileName [
	^ defaultFileName
]

{ #category : #accessing }
TinyLogger >> defaultFileName: anObject [
	defaultFileName := anObject
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

{ #category : #logging }
TinyLogger >> execute: aBlock recordedAs: aString [
	self increaseDepthLevel.
	self record: 'Begin:	' , aString.
	self increaseDepthLevel.
	aBlock cull: aString.
	self decreaseDepthLevel.
	self record: 'End:	' , aString.
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
	self defaultFileName: self class defaultFileName.
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

{ #category : #logging }
TinyLogger >> record: aString [
	self loggers do: [ :each | each record: aString ]
]

{ #category : #'adding/removing' }
TinyLogger >> removeAllLoggers [
	self loggers do: [ :each | self removeLogger: each ]
]

{ #category : #'adding/removing' }
TinyLogger >> removeFileLoggers [
	self fileLoggers removeAll
]

{ #category : #'adding/removing' }
TinyLogger >> removeLogger: aLogger [
	(self loggersMap at: aLogger kind ifAbsentPut: [ OrderedCollection new ]) remove: aLogger
]

{ #category : #'adding/removing' }
TinyLogger >> removeStdoutLoggers [
	self stdoutLoggers removeAll
]

{ #category : #'adding/removing' }
TinyLogger >> removeTranscriptLoggers [
	self transcriptLoggers removeAll
]

{ #category : #'accessing - loggers' }
TinyLogger >> stdoutLoggers [
	^ self loggersMap at: TinySTDOutLogger kind ifAbsentPut: [ OrderedCollection new ]
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

{ #category : #'adding/removing' }
TinyLogger >> withDefaultLoggers [
	self
		removeAllLoggers;
		addTranscriptLogger;
		addStdoutLogger;
		addFileLogger
]
