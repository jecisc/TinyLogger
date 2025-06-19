# User documentation of TinyLogger

`TinyLogger` is a logger implementation (no kidding?!) for Pharo whose goal is to be small and simple.

Users can configure the way the logger works and the image will use this configured logger as default to record information. 

For specific cases, a specialized logger can be used.

- [User documentation of TinyLogger](#user-documentation-of-tinylogger)
	- [Configure your logger](#configure-your-logger)
		- [Add sub-loggers to your `TinyLogger`](#add-sub-loggers-to-your-tinylogger)
		- [Remove sub-loggers](#remove-sub-loggers)
		- [List the sub-loggers](#list-the-sub-loggers)
		- [Further configurations](#further-configurations)
			- [Configure the timestamp](#configure-the-timestamp)
			- [Configure the identation string](#configure-the-identation-string)
	- [Record with your logger](#record-with-your-logger)
		- [Record a single line log](#record-a-single-line-log)
		- [Recording the execution of a task](#recording-the-execution-of-a-task)
	- [Lazy recording](#lazy-recording)
	- [Use a logger other than the global logger](#use-a-logger-other-than-the-global-logger)
	- [Clear your logger](#clear-your-logger)
	- [Use special logger for tests](#use-special-logger-for-tests)
 

## Configure your logger

The first step to use `TinyLogger` will be to configure the default logger that will be used by the image.

For most of the cases, the user will only interact with `TinyLogger` class. `TinyLogger` is a composite to which *leaf* loggers can be added. *Leaf* loggers have the responsibility to log information in a specific manner. For example `TinyLogger` has a *leaf* logger to print information on Stdout of the application.

### Add sub-loggers to your `TinyLogger`

The default instance of `TinyLogger` has no logger registered when it is initialized. The first step will be to add one or many loggers to it. 

Here is the list of loggers available by default:
* `TinyStdoutLogger`: This logger records information on the *stdout* of the application.
* `TinyTranscriptLogger`: This logger records information on the Pharo's `Transcript`.
* `TinyFileLogger`: This logger records information in a file on the user file system. By default the file will be named `TinyLogger.log` and located in the image directory, but the file can be customized.

A *leaf* logger can be added to the default logger via the method `addLogger:` like this:

```Smalltalk
	TinyLogger default addLogger: TinyStdoutLogger new
```

But all default *leaf* loggers have a method to create a new instance and the new instance to the `TinyLogger` already present.

Here is an example adding a stdout logger, a transcript logger, a file logger with the default file name and a file logger with a customized name to the default `TinyLogger` instance:

```Smalltalk
TinyLogger default
	addStdoutLogger;
	addTranscriptLogger;
	addFileLogger;
	addFileLoggerNamed: '../logs/MyOtherLog.log'.
```

Additionaly to those methods, `TinyLogger` also propose ways to add loggers only if they have no equivalent already registered.

To archieve this result, use the equivalent of the methods previously explained, replacing `add` by `ensure`:
```Smalltalk
TinyLogger default
	ensureStdoutLogger;
	ensureTranscriptLogger;
	ensureFileLogger;
	ensureFileLoggerNamed: '../logs/MyOtherLog.log'.
```

With those methods, Transcript and Stdout loggers will be limited to one, and file loggers will be limited to one by file name.

### Remove sub-loggers

If at some point you want to remove one or multiple loggers, `TinyLogger` has an API for that. 

The first way to remove loggers is with the method `removeAllLoggers`, which removes all the loggers of each kind.

```Smalltalk
TinyLogger default removeAllLoggers
```

A second way to remove loggers is to remove them by kind:
* `removeFileLoggers`
* `removeTranscriptLoggers`
* `removeStdoutLoggers`

```Smalltalk
TinyLogger default removeFileLoggers
```

A last way is to use the method `removeLogger:` with the logger to remove.

```Smalltalk
TinyLogger default fileLoggers
	select: [ :logger | logger fileName beginsWith: 'Test' ]
	thenDo: [ :logger | TinyLogger default removeLogger: logger ]
```

### List the sub-loggers

If you wish to get the list of loggers in a `TinyLogger` you can use the `loggers` method:

```Smalltalk
TinyLogger default loggers
```

You can also get it in the form of a dictionary with the kind of logger as keys and the instanciated loggers of this kind as values via the `loggersMap` method.

```Smalltalk
TinyLogger default loggersMap
```

If you with to know all the loggers of a kind, you can use:
* `fileLoggers`
* `transcriptLoggers`
* `stdoutLoggers`

### Further configurations

#### Configure the timestamp

By default, the preamble of the log will be a timestamp with a human readable format, e.g.: 

```
2018-11-29T23:19:55.511775+01:00 : Test
```

But this format is configurable. The `timestampFormatBlock:` method can be used with a parameter that is a block taking a stream as parameter and the timestamp (instance of `DateAndTime`) and use that to write the preamble on the stream.

```Smalltalk
TinyLogger default
		timestampFormatBlock: [ :aStream :timestamp | 
			timestamp asDate printOn: aStream.
			aStream << ' '.	"Cannot use #space because of Stdio streams"
			timestamp asTime print24: true on: aStream ]
```

This will produce logs of this format:

```
29 November 2018 00:06:30 : Test
```

#### Configure the identation string

By default using #`execute:recordedAs:` will use a tab for identation. It is possible to configure this using `#identationString:` to have, for example, spaces.

```Smalltalk
TinyLogger default identationString: '  '. "Two spaces"
self execute: [ 'Log' record ] recordedAs: 'Task'
```

Will produce a log like this:

```
2018-11-29T23:21:04.897775+01:00 : 	Begin: Task
2018-11-29T23:21:04.900775+01:00 : 	  Log
2018-11-29T23:21:04.909775+01:00 : 	End: Task
```

On the second line, the identation will use two spaces instead of a tab that is the default value.

## Record with your logger

This section will cover the API to record information. 

### Record a single line log

To record a single line on a log, you can just use the method `record`:

```Smalltalk
'This is a string to log' record
```

This will produce a log like this with the default `timestampFormatBlock`:

```
2018-11-29T23:19:55.511775+01:00 : This is a string to log
```

### Recording the execution of a task

To record the execution of a task you can use the method `execute:recordedAs:`

```Smalltalk
self execute: [ 1 to: 5 do: [ :value | value asString record ] ] recordedAs: 'Task with only one nesting.'
```

Will produce a log like this:

```
2018-11-29T23:21:04.897775+01:00 : 	Begin: Task with only one nesting.
2018-11-29T23:21:04.900775+01:00 : 		1
2018-11-29T23:21:04.902775+01:00 : 		2
2018-11-29T23:21:04.904775+01:00 : 		3
2018-11-29T23:21:04.906775+01:00 : 		4
2018-11-29T23:21:04.908775+01:00 : 		5
2018-11-29T23:21:04.909775+01:00 : 	End: Task with only one nesting.
```

It is also possible to nest them:

```Smalltalk
self execute: [ 
	1 to: 4 do: [ :value1 | 
		self execute: [
			1 to: value1 do: [ :value2 | value2 asString record ]
			] recordedAs: 'My second nest'
		 ]
	 ] recordedAs: 'My first nest'.
```

It will produce this kind of output:

```
2018-11-29T23:21:20.147775+01:00 : 	Begin: My first nest
2018-11-29T23:21:20.151775+01:00 : 			Begin: My second nest
2018-11-29T23:21:20.153775+01:00 : 				1
2018-11-29T23:21:20.155775+01:00 : 			End: My second nest
2018-11-29T23:21:20.157775+01:00 : 			Begin: My second nest
2018-11-29T23:21:20.158775+01:00 : 				1
2018-11-29T23:21:20.160775+01:00 : 				2
2018-11-29T23:21:20.161775+01:00 : 			End: My second nest
2018-11-29T23:21:20.163775+01:00 : 			Begin: My second nest
2018-11-29T23:21:20.164775+01:00 : 				1
2018-11-29T23:21:20.165775+01:00 : 				2
2018-11-29T23:21:20.167775+01:00 : 				3
2018-11-29T23:21:20.169775+01:00 : 			End: My second nest
2018-11-29T23:21:20.171775+01:00 : 			Begin: My second nest
2018-11-29T23:21:20.172775+01:00 : 				1
2018-11-29T23:21:20.175775+01:00 : 				2
2018-11-29T23:21:20.176775+01:00 : 				3
2018-11-29T23:21:20.177775+01:00 : 				4
2018-11-29T23:21:20.179775+01:00 : 			End: My second nest
2018-11-29T23:21:20.180775+01:00 : 	End: My first nest
```

## Lazy recording

In some cases we might want to record things and it takes time to build the string to record. In that case, it is possible to use a block to do the recording, and this block will be executed if there is at least one logger registered. Like this, if no logger is set, the block will be ignored and the application will not slow down.

```Smalltalk

self record: [ String streamContents: [ :aStream | aStream nextPutAll: '{ something to compute }' ] ].

[ String streamContents: [ :aStream | aStream nextPutAll: '{ something to compute }' ] ] record
```

> #execute:recordedAs: works in the same way. It is possible to pass a block as a second parameter and if no logger is present, this block will not be executed.

## Use a logger other than the global logger

In some cases we may not want to use the default logger for a part of the application.

`TinyLogger` allows using a custom logger during the execution of a process by changing the value of `TinyCurrentLogger`:

```Smalltalk
| customLogger |
customLogger := TinyLogger new
	addTranscriptLogger;
	yourself.
	
TinyCurrentLogger value: customLogger during: [
	'test' record.
	TinyCurrentLogger value record: 'Test2'
]
```

## Clear your logger

Each logger understands the method `#clearLog`. This method will have as effect to clear the output of the loggers. The actual effect is different depending on the kind of logger:
- `TinyLogger` will send the message to all its sub loggers
- `Transcript` logger will clear the Transcript of Pharo
- `Stdout` logger will do nothing because it is not possible to clean a stdout
- `File` logger will erase the file used to log

```Smalltalk
TinyLogger default clearLogger
```

## Use special logger for tests

It is probable that you might not want to have your default logger for tests. It is possible to archive this by overriding the #performTest method of your TestCase like this:

```Smalltalk
MyTestCase>>performTest
	| testLogger |
	testLogger := TinyLogger new
		addTranscriptLogger;
		yourself.
		
	TinyCurrentLogger value: testLogger during: [
		super performTest
	]
```

Doing this, your tests will use the `testLogger` instead of the default logger in the image.
