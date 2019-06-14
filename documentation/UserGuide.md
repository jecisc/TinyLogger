# User documentation of TinyLogger

`TinyLogger` is a logger implementation (no kidding?!) for Pharo whose goal is to be small and simple.

Users can configure the way the logger works and the image will use this configured logger as default to record information. 

For specific cases, a specialized logger can be used.

- [User documentation of TinyLogger](#user-documentation-of-tinylogger)
  * [Quick start](#quick-start)
  * [Configure your logger](#configure-your-logger)
    + [Add sub-loggers to your `TinyLogger`](#add-sub-loggers-to-your-tinylogger-)
    + [Remove sub-loggers](#remove-sub-loggers)
    + [List the sub-loggers](#list-the-sub-loggers)
    + [Configure the timestamp format](#configure-the-timestamp-format)
  * [Record with your logger](#record-with-your-logger)
    + [Record a single line log](#record-a-single-line-log)
    + [Recording the execution of a task](#recording-the-execution-of-a-task)
  * [Use another logger than the global logger](#use-another-logger-than-the-global-logger)
  * [Clear your logger](#clear-your-logger)
  
## Quick start

This section will explain in 30 seconds how to create a logger for an application and use it. Then we will explore more advance features.

Here is an example fo snippet to create a logger using a file `Progress.log`:

```Smalltalk
TinyLogger default 
    addFileLoggerNamed: 'Progress.log'.
```

This code need to be executed **one time** in the image. For an application, it will probably be added to a method *initialize* on the class side of a class to be executed one time at the loading of the project in the image.

In case you need to execute the code multiple times you can use this snippet instead:

```Smalltalk
TinyLogger default 
    ensureFileLoggerNamed: 'Progress.log'.
```

Then write a message to the log using `record`:

```Smalltalk
'Uh oh. Something happened.' record
```

Or wrap the execution of an action by logs using `execute:recordedAs:`:

```Smalltalk
self execute: [ "Some code doing something" ] recordedAs: 'Launching bananas.'
```

Now, if you want to know more about the project, let's proceed on a more detailed documentation.

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

In order to archieve this result, you can use the equivalent of the methods previously explained, replacing `add` by `ensure`:
```Smalltalk
TinyLogger default
	ensureStdoutLogger;
	ensureTranscriptLogger;
	ensureFileLogger;
	ensureFileLoggerNamed: '../logs/MyOtherLog.log'.
```

With those methods, Transcript and Stdout loggers will be limited to one, and file loggers will be limited to one by file name.

### Remove sub-loggers

If at some point you wants to remove one or multiple loggers, `TinyLogger` has some API elements to do that. 

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

### Configure the timestamp format

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

Each logger can understand the method `#clearLogger`. This method will have as effet to clear the output of the loggers. The actual effect can be slightly different depending on the kind of logger:
- `TinyLogger` will send the message to all its sub loggers
- `Transcript` logger will clear the Transcript of Pharo
- `Stdout` logger will do nothing because it is not possible to clean a stdout
- `File` logger will erase the file used to log

```Smalltalk
TinyLogger default clearLogger
```
