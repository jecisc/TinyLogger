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
	
	self timestampFormatBlock value: aStream.
	aStream << ' : '.
	self depth timesRepeat: [ aStream tab ]
]

{ #category : #accessing }
TinyLeafLogger >> timestampFormatBlock [
	^ self parentLogger timestampFormatBlock
]
