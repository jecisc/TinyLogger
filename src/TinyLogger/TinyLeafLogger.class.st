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
	#name : #TinyLeafLogger,
	#superclass : #TinyAbstractLogger,
	#instVars : [
		'parentLogger'
	],
	#category : #'TinyLogger-Core'
}

{ #category : #'instance creation' }
TinyLeafLogger class >> for: aTinyLogger [
	^ self new
		parentLogger: aTinyLogger;
		yourself
]

{ #category : #testing }
TinyLeafLogger class >> isAbstract [
	^ self = TinyLeafLogger
]

{ #category : #accessing }
TinyLeafLogger class >> kind [
	^ self subclassResponsibility
]

{ #category : #accessing }
TinyLeafLogger >> depth [
	^ self parentLogger depth
]

{ #category : #accessing }
TinyLeafLogger >> kind [
	^ self class kind
]

{ #category : #logging }
TinyLeafLogger >> newLine [
	^ OSPlatform current lineEnding
]

{ #category : #accessing }
TinyLeafLogger >> parentLogger [
	^ parentLogger
]

{ #category : #accessing }
TinyLeafLogger >> parentLogger: aLogger [
	parentLogger == aLogger ifTrue: [ ^ self ].
	parentLogger := aLogger
]

{ #category : #logging }
TinyLeafLogger >> record: aString on: aStream [
	self recordPreambleOn: aStream.
	aStream << aString << self newLine
]

{ #category : #accessing }
TinyLeafLogger >> recordPreambleOn: aStream [
	<compilerOptions: #(+ optionInlineTimesRepeat)>
	
	self timestampFormatBlock cull: aStream cull: DateAndTime now.
	aStream << ' : '.
	"We use explicit tab writing instead of #tab or #tab: because not all streams understand those methods"
	self depth timesRepeat: [ aStream nextPut: Character tab ]
]

{ #category : #accessing }
TinyLeafLogger >> timestampFormatBlock [
	^ self parentLogger timestampFormatBlock
]
