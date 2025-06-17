"
A TinyFileLoggerTest is a test class for testing the behavior of TinyFileLogger
"
Class {
	#name : 'TinyFileLoggerTest',
	#superclass : 'TinyLeafLoggerTest',
	#instVars : [
		'log'
	],
	#category : 'TinyLogger-Tests-Core',
	#package : 'TinyLogger-Tests',
	#tag : 'Core'
}

{ #category : 'helpers' }
TinyFileLoggerTest >> actualClass [
	^ TinyFileLogger
]

{ #category : 'tests' }
TinyFileLoggerTest >> fileNameNumber: number [
	^ 'testFile' , number asString , 'ForTinyLogger.log'
]

{ #category : 'running' }
TinyFileLoggerTest >> tearDown [
	log ifNotNil: #ensureDelete.
	super tearDown
]

{ #category : 'tests' }
TinyFileLoggerTest >> testCanHaveDefaultFile [
	self shouldnt: [ self actualClass new fileReference ] raise: Error
]

{ #category : 'tests' }
TinyFileLoggerTest >> testClearLog [
	log := (self fileNameNumber: 1) asFileReference.
	logger := self actualClass for: parentLogger named: log basename.
	logger record: 'this is a test'.

	self assert: log exists.
	logger clearLog.
	self deny: log exists
]

{ #category : 'tests' }
TinyFileLoggerTest >> testFileName [
	log := (self fileNameNumber: 4) asFileReference.
	logger := self actualClass for: parentLogger named: log basename.
	logger record: 'this is a test'.

	self assert: (self fileNameNumber: 4) asFileReference exists
]

{ #category : 'tests' }
TinyFileLoggerTest >> testIdentationString [

	log := (self fileNameNumber: 1) asFileReference.
	logger := self actualClass for: parentLogger named: log basename.
	parentLogger identationString: '--'.

	logger execute: [ logger record: 'this is a test' ] recordedAs: 'block'.

	self assert: log exists.
	self assert: log contents lines isNotEmpty.
	self assert: (log contents lines second includesSubstring: '--this is a test')
]

{ #category : 'tests' }
TinyFileLoggerTest >> testLoggerCreatesFile [
	log := (self fileNameNumber: 10) asFileReference.
	logger := self actualClass for: parentLogger named: log basename.
	self deny: log exists.

	logger record: 'this is a test'.
	self assert: log exists
]

{ #category : 'tests' }
TinyFileLoggerTest >> testRecord [
	log := (self fileNameNumber: 1) asFileReference.
	logger := self actualClass for: parentLogger named: log basename.
	logger record: 'this is a test'.

	self assert: log exists.
	self assert: log contents lines isNotEmpty.
	self assert: (log contents lines last includesSubstring: 'this is a test')
]

{ #category : 'tests' }
TinyFileLoggerTest >> testRecordSetFileToTheEnd [
	log := (self fileNameNumber: 1) asFileReference.
	logger := self actualClass for: parentLogger named: log basename.
	logger record: 'this is a test'.

	self assert: log contents lines size equals: 1.
	logger record: 'this is a test2'.
	self assert: log contents lines size equals: 2
]
