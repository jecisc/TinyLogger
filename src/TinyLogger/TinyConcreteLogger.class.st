Class {
	#name : #TinyConcreteLogger,
	#superclass : #TinyAbstractLogger,
	#instVars : [
		'parentLogger'
	],
	#category : #'TinyLogger-Core'
}

{ #category : #'instance creation' }
TinyConcreteLogger class >> for: aTinyLogger [
	^ self new
		parentLogger: aTinyLogger;
		yourself
]

{ #category : #testing }
TinyConcreteLogger class >> isAbstract [
	^ self = TinyConcreteLogger
]

{ #category : #logging }
TinyConcreteLogger >> crRecord: aString on: aStream [
	aStream << self newLine.
	self record: aString on: aStream
]

{ #category : #accessing }
TinyConcreteLogger >> depth [
	^ self parentLogger depth
]

{ #category : #logging }
TinyConcreteLogger >> newLine [
	^ OSPlatform current lineEnding
]

{ #category : #accessing }
TinyConcreteLogger >> parentLogger [
	^ parentLogger
]

{ #category : #accessing }
TinyConcreteLogger >> parentLogger: aLogger [
	parentLogger := aLogger
]

{ #category : #logging }
TinyConcreteLogger >> record: aString on: aStream [
	self recordPreambleOn: aStream.
	aStream << aString
]

{ #category : #logging }
TinyConcreteLogger >> recordCr: aString on: aStream [
	self record: aString on: aStream.
	aStream << self newLine
]

{ #category : #accessing }
TinyConcreteLogger >> recordPreambleOn: aStream [
	<compilerOptions: #(+ optionInlineTimesRepeat)>
	
	self timestampFormatBlock value: aStream.
	aStream << ' : '.
	self depth timesRepeat: [ aStream tab ]
]

{ #category : #accessing }
TinyConcreteLogger >> timestampFormatBlock [
	^ self parentLogger timestampFormatBlock
]
