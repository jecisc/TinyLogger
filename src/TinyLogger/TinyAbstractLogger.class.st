"
Description
--------------------

I am an abstract logger to define the minimal behavior all my subclasses should define.

The user should mostly work with the `TinyLogger` class. This class is the main entry point of the project.

I follow a composite design pattern. I am subclassed by a `TinyLogger` that is a composite of leaf loggers, and `TinyLeafLogger` defining the behavior of a concrete logger.

Users should configure a `TinyLogger` with the concrete loggers they want and use this one that will dispatch the logging behavior to the other loggers.

Public API and Key Messages
--------------------

- #record: 	Takes a string and record it.
- #<< 			Alias of #record:

"
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
TinyAbstractLogger >> clearLogger [
	"Whe called, this method should clear the previous logs"

	self subclassResponsibility
]

{ #category : #logging }
TinyAbstractLogger >> record: aString [
	self subclassResponsibility
]

{ #category : #accessing }
TinyAbstractLogger >> timestampFormatBlock [
	^ self subclassResponsibility
]
