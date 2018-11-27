"
A TinyFileLoggerTest is a test class for testing the behavior of TinyFileLogger
"
Class {
	#name : #TinyFileLoggerTest,
	#superclass : #TinyLeafLoggerTest,
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

{ #category : #test }
TinyFileLoggerTest >> testFileName [
	| log |
	log := (self fileNameNumber: 4) asFileReference.
	[
	logger := self actualClass for: parentLogger named: log basename.
	logger record: 'this is a test'.
	self assert: (self fileNameNumber: 4) asFileReference exists ]
		ensure: [ (log isNotNil and: [ log exists ])
				ifTrue: [ log ensureDelete ] ]
]

{ #category : #test }
TinyFileLoggerTest >> testLoggerCreatesFile [
	| log |
	log := (self fileNameNumber: 10) asFileReference.
	[
	logger := self actualClass for: parentLogger named: log basename.
	self deny: log exists.
	logger record: 'this is a test'.
	self assert: log exists ]
		ensure: [ (log isNotNil and: [ log exists ])
				ifTrue: [ log ensureDelete ] ]
]

{ #category : #test }
TinyFileLoggerTest >> testRecord [
	| log |
	log := (self fileNameNumber: 1) asFileReference.
	[
	logger := self actualClass for: parentLogger named: log basename.
	logger record: 'this is a test'.
	
	self assert: log exists.
	self assert: log contents lines isNotEmpty.
	self assert: (log contents lines last includesSubstring: 'this is a test') ]
		ensure: [ (log isNotNil and: [ log exists ])
				ifTrue: [ log ensureDelete ] ]
]

{ #category : #test }
TinyFileLoggerTest >> testRecordSetFileToTheEnd [
	| log |
	log := (self fileNameNumber: 1) asFileReference.
	[
	logger := self actualClass for: parentLogger named: log basename.
	logger record: 'this is a test'.

	self assert: log contents lines size equals: 1.
	logger record: 'this is a test2'.
	self assert: log contents lines size equals: 2 ]
		ensure: [ (log isNotNil and: [ log exists ])
				ifTrue: [ log ensureDelete ] ]
]
