"
A TinyLoggerTest is a test class for testing the behavior of TinyLogger
"
Class {
	#name : 'TinyLoggerTest',
	#superclass : 'TinyAbstractLoggerTest',
	#category : 'TinyLogger-Tests-Core',
	#package : 'TinyLogger-Tests',
	#tag : 'Core'
}

{ #category : 'helpers' }
TinyLoggerTest >> actualClass [
	^ TinyLogger
]

{ #category : 'private' }
TinyLoggerTest >> performTest [

	TinyCurrentLogger value: logger during: [ super performTest ]
]

{ #category : 'running' }
TinyLoggerTest >> setUp [
	super setUp.
	logger := TinyLogger new
]

{ #category : 'tests' }
TinyLoggerTest >> testAddFileLogger [
	logger removeAllLoggers.
	self assert: logger loggers isEmpty.
	
	logger
		addFileLogger;
		addFileLogger.
	self assert: logger loggers size equals: 2.
	self assert: logger fileLoggers size equals: 2
]

{ #category : 'tests' }
TinyLoggerTest >> testAddFileLoggerNamed [
	logger removeAllLoggers.
	self assert: logger loggers isEmpty.
	
	logger addFileLoggerNamed: 'test.log'.
	self assert: logger fileLoggers size equals: 1.
	self assert: logger loggers anyOne fileName equals: 'test.log'
]

{ #category : 'tests' }
TinyLoggerTest >> testAddLogger [
	logger removeAllLoggers.
	self assert: logger loggers isEmpty.
	
	logger
		addLogger: (TinyFileLogger for: logger);
		addLogger: (TinyFileLogger for: logger named: 'test.log').
	self assert: logger loggers size equals: 2.
	self assert: logger fileLoggers size equals: 2
]

{ #category : 'tests' }
TinyLoggerTest >> testAddStdoutLogger [
	logger removeAllLoggers.
	self assert: logger loggers isEmpty.

	logger
		addStdoutLogger;
		addStdoutLogger.
	self assert: logger loggers size equals: 2.
	self assert: logger stdoutLoggers size equals: 2
]

{ #category : 'tests' }
TinyLoggerTest >> testAddTranscriptLogger [
	logger removeAllLoggers.
	self assert: logger loggers isEmpty.
	
	logger
		addTranscriptLogger;
		addTranscriptLogger.
	self assert: logger loggers size equals: 2.
	self assert: logger transcriptLoggers size equals: 2
]

{ #category : 'tests' }
TinyLoggerTest >> testClearLog [
	logger
		addTranscriptLogger;
		addFileLoggerNamed: 'testFileForTinyLogger.log';
		addFileLoggerNamed: 'testFileForTinyLogger2.log'.

	logger record: 'Test'.
	self assert: (logger fileLoggers allSatisfy: [ :fileLogger | fileLogger fileReference exists ]).

	logger clearLog.
	self assert: (logger fileLoggers noneSatisfy: [ :fileLogger | fileLogger fileReference exists ])
]

{ #category : 'tests' }
TinyLoggerTest >> testCurrentLogger [
	self assert: TinyCurrentLogger value isNotNil.
	self assert: TinyCurrentLogger value class equals: TinyLogger
]

{ #category : 'tests' }
TinyLoggerTest >> testEnsureFileLogger [
	logger removeAllLoggers.
	self assert: logger loggers isEmpty.

	logger ensureFileLogger.
	self assert: logger loggers size equals: 1.
	self assert: logger fileLoggers size equals: 1.

	logger ensureFileLogger.
	self assert: logger loggers size equals: 1.
	self assert: logger fileLoggers size equals: 1
]

{ #category : 'tests' }
TinyLoggerTest >> testEnsureFileLoggerNamed [
	logger removeAllLoggers.
	self assert: logger loggers isEmpty.

	logger ensureFileLoggerNamed: 'test.log'.
	self assert: logger fileLoggers size equals: 1.

	logger ensureFileLoggerNamed: 'test.log'.
	logger ensureFileLoggerNamed: 'test2.log'.
	self assert: logger fileLoggers size equals: 2
]

{ #category : 'tests' }
TinyLoggerTest >> testEnsureStdoutLogger [
	logger removeAllLoggers.
	self assert: logger loggers isEmpty.

	logger
		ensureStdoutLogger;
		ensureStdoutLogger.
	self assert: logger loggers size equals: 1.
	self assert: logger stdoutLoggers size equals: 1
]

{ #category : 'tests' }
TinyLoggerTest >> testEnsureTranscriptLogger [
	logger removeAllLoggers.
	self assert: logger loggers isEmpty.
	
	logger
		ensureTranscriptLogger;
		ensureTranscriptLogger.
	self assert: logger loggers size equals: 1.
	self assert: logger transcriptLoggers size equals: 1
]

{ #category : 'tests' }
TinyLoggerTest >> testExecuteRecordedAs [
	| contents stream bool |
	self skipInPharo6.
	bool := false.
	logger
		removeAllLoggers;
		addStdoutLogger.
	stream := '' writeStream.
	[ Stdio stub stdout willReturn: stream.
	logger execute: [ bool := true ] recordedAs: 'This is a new test'.
	contents := Stdio stdout contents asString.
	self assert: bool.
	self assert: (contents includesSubstring: 'Begin: This is a new test').
	self assert: (contents includesSubstring: 'End: This is a new test') ]
		ensure: [ Stdio recoverFromGHMutation.
			stream close ]
]

{ #category : 'tests' }
TinyLoggerTest >> testExecuteRecordedAs2 [
	| contents stream |
	self skipInPharo6.
	logger
		timestampFormatBlock: [ :s | s nextPutAll: 'No time' ];
		removeAllLoggers;
		addStdoutLogger.
	stream := '' writeStream.
	[ Stdio stub stdout willReturn: stream.
	TinyCurrentLogger value: logger during: [ Object new execute: [ 'test' record ] recordedAs: 'This is a new test' ].
	contents := Stdio stdout contents asString.

	"Ensure we have the right indentation."
	self
		assert: contents withUnixLineEndings
		equals:
			'No time : 	Begin: This is a new test
No time : 		test
No time : 	End: This is a new test
' withUnixLineEndings ]
		ensure: [ Stdio recoverFromGHMutation.
			stream close ]
]

{ #category : 'tests' }
TinyLoggerTest >> testExecuteRecordedAsKeepRightIndentation [

	| contents stream errorDetected |
	self skipInPharo6.
	errorDetected := false.
	logger
		timestampFormatBlock: [ :s | s nextPutAll: 'No time' ];
		removeAllLoggers;
		addStdoutLogger.
	stream := '' writeStream.
	[ 
	Stdio stub stdout willReturn: stream.
	TinyCurrentLogger value: logger during: [ 
		[ Object new execute: [ Error signal: 'test' ] recordedAs: 'This is a new test' ]
			on: Error
			do: [ errorDetected := true ].
		Object new execute: [ 'test' record ] recordedAs: 'This is a new test' ].
	contents := Stdio stdout contents asString.
	"Ensure we have the right indentation."
	self assert: errorDetected.
	self assert: contents withUnixLineEndings equals: 'No time : 	Begin: This is a new test
No time : 	End with error: This is a new test.Error message: "Error: test"
No time : 	Begin: This is a new test
No time : 		test
No time : 	End: This is a new test
' withUnixLineEndings ] ensure: [ 
		Stdio recoverFromGHMutation.
		stream close ]
]

{ #category : 'tests' }
TinyLoggerTest >> testExecuteRecordedAsReturnBlockContent [
	| contents stream bool |
	self skipInPharo6.
	bool := false.
	logger
		removeAllLoggers;
		addStdoutLogger.
	stream := '' writeStream.
	[ Stdio stub stdout willReturn: stream.
	bool := logger execute: [ true ] recordedAs: 'This is a new test'.
	contents := Stdio stdout contents asString.
	self assert: bool.
	self assert: (contents includesSubstring: 'Begin: This is a new test').
	self assert: (contents includesSubstring: 'End: This is a new test') ]
		ensure: [ Stdio recoverFromGHMutation.
			stream close ]
]

{ #category : 'tests' }
TinyLoggerTest >> testFileLoggers [
	logger
		addTranscriptLogger;
		addFileLoggerNamed: 'test.log';
		addFileLoggerNamed: 'test2.log'.
	self assert: logger loggers size equals: 3.
	self assert: logger fileLoggers size equals: 2.
	self assert: (logger fileLoggers allSatisfy: [ :each | each kind = TinyFileLogger kind ]).
	self assert: (logger fileLoggers anySatisfy: [ :each | each kind = TinyFileLogger kind and: [ each fileName = 'test.log' ] ]).
	self assert: (logger fileLoggers anySatisfy: [ :each | each kind = TinyFileLogger kind and: [ each fileName = 'test2.log' ] ])
]

{ #category : 'tests' }
TinyLoggerTest >> testHasLoggers [
	self deny: logger hasLoggers.
	logger addFileLogger.
	self assert: logger hasLoggers
]

{ #category : 'tests' }
TinyLoggerTest >> testIndentationString [

	| contents stream bool |
	self skipInPharo6.
	bool := false.
	logger
		removeAllLoggers;
		addStdoutLogger;
		indentationString: '--'.
	stream := '' writeStream.
	[
		Stdio stub stdout willReturn: stream.
		logger execute: [ 'test' record ] recordedAs: 'This is a new test'.
		contents := Stdio stdout contents asString.
		self assert: (contents includesSubstring: '--test') ] ensure: [
			Stdio recoverFromGHMutation.
			stream close ]
]

{ #category : 'tests' }
TinyLoggerTest >> testLoggers [
	logger
		addTranscriptLogger;
		addFileLoggerNamed: 'test.log';
		addFileLoggerNamed: 'test2.log'.
	self assert: logger loggers size equals: 3.
	self assert: (logger loggers anySatisfy: [ :each | each kind = TinyFileLogger kind and: [ each fileName = 'test.log' ] ]).
	self assert: (logger loggers anySatisfy: [ :each | each kind = TinyFileLogger kind and: [ each fileName = 'test2.log' ] ]).
	self assert: (logger loggers anySatisfy: [ :each | each kind = TinyTranscriptLogger kind ])
]

{ #category : 'tests' }
TinyLoggerTest >> testNestedExecuteRecordedAs [
	| contents stream bool1 bool2 |
	self skipInPharo6.
	bool1 := false.
	bool2 := false.
	logger
		removeAllLoggers;
		addStdoutLogger.
	stream := '' writeStream.
	[ Stdio stub stdout willReturn: stream.
	logger
		execute: [ bool1 := true.
			logger execute: [ bool2 := true ] recordedAs: 'Test2' ]
		recordedAs: 'Test1'.
	contents := Stdio stdout contents asString.
	self assert: bool1.
	self assert: bool2.
	self assert: (contents includesSubstring: '	Begin: Test1').
	self assert: (contents includesSubstring: '	End: Test1').
	self assert: (contents includesSubstring: '			Begin: Test2').
	self assert: (contents includesSubstring: '			End: Test2') ]
		ensure: [ Stdio recoverFromGHMutation.
			stream close ]
]

{ #category : 'tests' }
TinyLoggerTest >> testRecord [
	| contents stream |
	self skipInPharo6.
	logger
		removeAllLoggers;
		addStdoutLogger;
		addStdoutLogger;
		addTranscriptLogger.
	stream := '' writeStream.
	[ Stdio stub stdout willReturn: stream.
	logger record: 'This is a new test'.
	contents := Stdio stdout contents asString lines.
	self assert: (contents last includesSubstring: 'This is a new test').
	self assert: ((contents at: contents size - 1) includesSubstring: 'This is a new test') ]
		ensure: [ Stdio recoverFromGHMutation.
			stream close ]
]

{ #category : 'tests' }
TinyLoggerTest >> testRecord2 [
	| contents stream |
	self skipInPharo6.
	logger
		removeAllLoggers;
		addStdoutLogger;
		addStdoutLogger;
		addTranscriptLogger.
	stream := '' writeStream.
	[ Stdio stub stdout willReturn: stream.
	logger << 'This is a new test'.
	contents := Stdio stdout contents asString lines.
	self assert: (contents last includesSubstring: 'This is a new test').
	self assert: ((contents at: contents size - 1) includesSubstring: 'This is a new test') ]
		ensure: [ Stdio recoverFromGHMutation.
			stream close ]
]

{ #category : 'tests' }
TinyLoggerTest >> testRecord3 [
	| log |
	log :=  'testFileForTinyLogger.log' asFileReference.
	[
	logger addFileLoggerNamed: log basename.
	
	TinyCurrentLogger value: logger during: [ 'this is a test' record ].
	
	self assert: log exists.
	self assert: log contents lines isNotEmpty.
	self assert: (log contents lines last includesSubstring: 'this is a test') ]
		ensure: [ (log isNotNil and: [ log exists ])
				ifTrue: [ log ensureDelete ] ]
]

{ #category : 'tests' }
TinyLoggerTest >> testRecordBlock [
	| log |
	log := 'testFileForTinyLogger.log' asFileReference.
	[
	TinyCurrentLogger value: logger during: [ logger record: [ self fail ] ].

	self deny: log exists ]
		ensure: [ (log isNotNil and: [ log exists ])
				ifTrue: [ log ensureDelete ] ]
]

{ #category : 'tests' }
TinyLoggerTest >> testRecordBlock2 [
	| log |
	log := 'testFileForTinyLogger.log' asFileReference.
	[
	logger addFileLoggerNamed: log basename.

	TinyCurrentLogger value: logger during: [ logger record: [ 'this is a test' ] ].

	self assert: log exists.
	self assert: (log contents includesSubstring: 'this is a test') ]
		ensure: [ (log isNotNil and: [ log exists ])
				ifTrue: [ log ensureDelete ] ]
]

{ #category : 'tests' }
TinyLoggerTest >> testRecordBlockReceiver [
	| log |
	log := 'testFileForTinyLogger.log' asFileReference.
	[
	TinyCurrentLogger value: logger during: [ [ self fail ] record ].

	self deny: log exists ]
		ensure: [ (log isNotNil and: [ log exists ])
				ifTrue: [ log ensureDelete ] ]
]

{ #category : 'tests' }
TinyLoggerTest >> testRecordBlockReceiver2 [
	| log |
	log := 'testFileForTinyLogger.log' asFileReference.
	[
	logger addFileLoggerNamed: log basename.

	TinyCurrentLogger value: logger during: [ [ 'this is a test' ] record ].

	self assert: log exists.
	self assert: (log contents includesSubstring: 'this is a test') ]
		ensure: [ (log isNotNil and: [ log exists ])
				ifTrue: [ log ensureDelete ] ]
]

{ #category : 'tests' }
TinyLoggerTest >> testRemoveAllLoggers [
	logger
		addTranscriptLogger;
		addFileLoggerNamed: 'test.log';
		addFileLoggerNamed: 'test2.log'.
	self assert: logger loggers size equals: 3.
	logger removeAllLoggers.
	self assert: logger loggers isEmpty
]

{ #category : 'tests' }
TinyLoggerTest >> testRemoveFileLoggers [
	logger
		addTranscriptLogger;
		addFileLoggerNamed: 'test.log';
		addFileLoggerNamed: 'test2.log'.
	self assert: logger loggers size equals: 3.
	logger removeFileLoggers.
	self assert: logger loggers size equals: 1
]

{ #category : 'tests' }
TinyLoggerTest >> testRemoveLogger [
	| logger1 logger2 |
	logger removeAllLoggers.
	self assert: logger loggers isEmpty.
	
	logger
		addLogger: (logger1 := TinyFileLogger for: logger);
		addLogger: (logger2 := TinyFileLogger for: logger named: 'test.log').
	self assert: logger loggers size equals: 2.
	
	logger removeLogger: logger1.
	self assert: logger loggers size equals: 1.
	self assert: logger loggers anyOne equals: logger2.
	
	logger removeLogger: logger2.
	self assert: logger loggers isEmpty
]

{ #category : 'tests' }
TinyLoggerTest >> testRemoveStdoutLoggers [
	logger
		addStdoutLogger;
		addStdoutLogger;
		addFileLoggerNamed: 'test.log'.
	self assert: logger loggers size equals: 3.
	logger removeStdoutLoggers.
	self assert: logger loggers size equals: 1
]

{ #category : 'tests' }
TinyLoggerTest >> testRemoveTranscriptLoggers [
	logger
		addTranscriptLogger;
		addTranscriptLogger;
		addFileLoggerNamed: 'test.log'.
	self assert: logger loggers size equals: 3.
	logger removeTranscriptLoggers.
	self assert: logger loggers size equals: 1
]

{ #category : 'tests' }
TinyLoggerTest >> testStdoutLoggers [
	logger
		addStdoutLogger;
		addStdoutLogger;
		addFileLoggerNamed: 'test.log'.
	self assert: logger loggers size equals: 3.
	self assert: logger stdoutLoggers size equals: 2.
	self assert: (logger stdoutLoggers allSatisfy: [ :each | each kind = TinyStdoutLogger kind ])
]

{ #category : 'tests' }
TinyLoggerTest >> testTranscriptLoggers [
	logger
		addTranscriptLogger;
		addTranscriptLogger;
		addFileLoggerNamed: 'test.log'.
	self assert: logger loggers size equals: 3.
	self assert: logger transcriptLoggers size equals: 2.
	self assert: (logger transcriptLoggers allSatisfy: [ :each | each kind = TinyTranscriptLogger kind ])
]

{ #category : 'tests' }
TinyLoggerTest >> testWithDefaultLoggers [
	| numberOfDefaultLoggers |
	logger withDefaultLoggers.
	self assert: logger loggers isNotEmpty.
	numberOfDefaultLoggers := logger loggers size.
	logger addStdoutLogger.
	logger withDefaultLoggers.
	"Ensure the loggers are reset when this method is called"
	self assert: logger loggers size equals: numberOfDefaultLoggers
]
