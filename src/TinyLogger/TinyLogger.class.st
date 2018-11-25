Class {
	#name : #TinyLogger,
	#superclass : #TinyAbstractLogger,
	#instVars : [
		'timestampFormatBlock',
		'defaultFileName',
		'transcriptLogger',
		'depth',
		'stdOutLogger',
		'fileLogger'
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

{ #category : #accessing }
TinyLogger >> allLoggers [
	^ {self transcriptLogger.
	self stdOutLogger.
	self fileLogger}
]

{ #category : #logging }
TinyLogger >> crRecord: aString [
	self allLoggers do: [ :each | each crRecord: aString ]
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

{ #category : #'enable/disable' }
TinyLogger >> disableFileLogger [
	self fileLogger: (TinyNilLogger for: self)
]

{ #category : #'enable/disable' }
TinyLogger >> disableLogger [
	self disableFileLogger.
	self disableTranscriptLogger.
	self disableSTDOutLogger
]

{ #category : #'enable/disable' }
TinyLogger >> disableSTDOutLogger [
	self stdOutLogger: (TinyNilLogger for: self)
]

{ #category : #'enable/disable' }
TinyLogger >> disableTranscriptLogger [
	self transcriptLogger: (TinyNilLogger for: self)
]

{ #category : #'enable/disable' }
TinyLogger >> enableFileLogger [
	self fileLogger: (TinyFileLogger for: self)
]

{ #category : #'enable/disable' }
TinyLogger >> enableLogger [
	self enableFileLogger.
	self enableTranscriptLogger.
	self enbleSTDOutLogger
]

{ #category : #'enable/disable' }
TinyLogger >> enableTranscriptLogger [
	self transcriptLogger: (TinyTranscriptLogger for: self)
]

{ #category : #'enable/disable' }
TinyLogger >> enbleSTDOutLogger [
	self stdOutLogger: (TinySTDOutLogger for: self)
]

{ #category : #accessing }
TinyLogger >> fileLogger [
	^ fileLogger
]

{ #category : #accessing }
TinyLogger >> fileLogger: anObject [
	fileLogger := anObject
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
	self defaultFileName: 'Application.log'.
	self enableLogger
]

{ #category : #logging }
TinyLogger >> record: aString [
	self allLoggers do: [ :each | each record: aString ]
]

{ #category : #logging }
TinyLogger >> recordCr: aString [
	self allLoggers do: [ :each | each recordCr: aString ]
]

{ #category : #accessing }
TinyLogger >> stdOutLogger [
	^ stdOutLogger
]

{ #category : #accessing }
TinyLogger >> stdOutLogger: anObject [
	stdOutLogger := anObject
]

{ #category : #accessing }
TinyLogger >> timestampFormatBlock [
	^ timestampFormatBlock
]

{ #category : #accessing }
TinyLogger >> timestampFormatBlock: anObject [
	timestampFormatBlock := anObject
]

{ #category : #accessing }
TinyLogger >> transcriptLogger [
	^ transcriptLogger
]

{ #category : #accessing }
TinyLogger >> transcriptLogger: anObject [
	transcriptLogger := anObject
]
