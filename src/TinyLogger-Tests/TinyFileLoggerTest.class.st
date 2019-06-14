"
A TinyFileLoggerTest is a test class for testing the behavior of TinyFileLogger
"
Class {
	#name : #TinyFileLoggerTest,
	#superclass : #TinyLeafLoggerTest,
	#instVars : [
		'log'
	],
	#category : #'TinyLogger-Tests-Core'
}

{ #category : #helpers }
TinyFileLoggerTest >> actualClass [
	^ TinyFileLogger
]

{ #category : #test }
TinyFileLoggerTest >> fileNameNumber: number [
	^ 'testFile' , number asString , 'ForTinyLogger.log'
]

{ #category : #running }
TinyFileLoggerTest >> tearDown [
	log ifNotNil: #ensureDelete.
	super tearDown
]

{ #category : #test }
TinyFileLoggerTest >> testCanHaveDefaultFile [
	self shouldnt: [ self actualClass new fileReference ] raise: Error
]

{ #category : #test }
TinyFileLoggerTest >> testClearLogger [
	log := (self fileNameNumber: 1) asFileReference.
	logger := self actualClass for: parentLogger named: log basename.
	logger record: 'this is a test'.

	self assert: log exists.
	logger clearLogger.
	self deny: log exists
]

{ #category : #test }
TinyFileLoggerTest >> testFileName [
	log := (self fileNameNumber: 4) asFileReference.
	logger := self actualClass for: parentLogger named: log basename.
	logger record: 'this is a test'.

	self assert: (self fileNameNumber: 4) asFileReference exists
]

{ #category : #test }
TinyFileLoggerTest >> testLoggerCreatesFile [
	log := (self fileNameNumber: 10) asFileReference.
	logger := self actualClass for: parentLogger named: log basename.
	self deny: log exists.

	logger record: 'this is a test'.
	self assert: log exists
]

{ #category : #test }
TinyFileLoggerTest >> testRecord [
	log := (self fileNameNumber: 1) asFileReference.
	logger := self actualClass for: parentLogger named: log basename.
	logger record: 'this is a test'.

	self assert: log exists.
	self assert: log contents lines isNotEmpty.
	self assert: (log contents lines last includesSubstring: 'this is a test')
]

{ #category : #test }
TinyFileLoggerTest >> testRecordSetFileToTheEnd [
	log := (self fileNameNumber: 1) asFileReference.
	logger := self actualClass for: parentLogger named: log basename.
	logger record: 'this is a test'.

	self assert: log contents lines size equals: 1.
	logger record: 'this is a test2'.
	self assert: log contents lines size equals: 2
]
