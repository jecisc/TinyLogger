Class {
	#name : #TinyAbstractLogger,
	#superclass : #Object,
	#category : #'TinyLogger-Core'
}

{ #category : #testing }
TinyAbstractLogger class >> isAbstract [
	^ self = TinyAbstractLogger
]

{ #category : #logging }
TinyAbstractLogger >> << aString [
	self record: aString
]

{ #category : #logging }
TinyAbstractLogger >> record: aString [
	self subclassResponsibility
]

{ #category : #accessing }
TinyAbstractLogger >> timestampFormatBlock [
	^ self subclassResponsibility
]
