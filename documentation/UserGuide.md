# User documentation of TinyLogger

`TinyLogger` is a logger implementation (no kidding?!) for Pharo whose goal is to be small and simple.

The users can configure the way they want the logger to work, then the image will use this default logger to record informations. 

For specific cases, a specilized logger can be used.

## Configure your logger

The first step to use `TinyLogger` will be to configure the default logger that will be used by the image.

For most of the cases, the user should only interact with the `TinyLogger` class. `TinyLogger` is a composite to which we can add some *leaf* loggers. The *leaf* loggers will be loggers that will have the responsibility to log informations in one way. For example `TinyLogger` has a *leaf* logger to record informations in the Stdout of the application.

### Add sub-loggers to your `TinyLogger`

The default instance of `TinyLogger` has no logger registered when it is initialized. The first step will be to add one or multiple loggers to it. 

Here is the list of loggers present by default in the project:
* `TinyStdoutLogger`: This logger will record informations on the *stdout* of the application.
* `TinyTranscriptLogger`: This logger will record informations on the Pharo's `Transcript`.
* `TinyFileLogger`: This logger will record informations in a file on the user file system. By default the file will be named `TinyLogger.log`, but the file can be customized.

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

### Remove sub-loggers

If at some point you wants to remove one or multiple loggers, `TineLogger` has some API elements to do that. 

The first way to remove loggers is with the method `removeAllLoggers`. This method will remove all the loggers of each kind.

```Smalltalk
  TinyLogger default removeAllLoggers
```

A second way to remove loggers is to remove all the loggers of one kind with the methods:
* `removeFileLoggers`
* `removeTranscriptLoggers`
* `removeStdoutLoggers`

```Smalltalk
  TinyLogger default removeFileLoggers
```

A last way is to use the method `removeLogger:` and giving as parameter the logger to remove.

```Smalltalk
  TinyLogger default fileLoggers
    select: [ :logger | logger fileName beginsWith: 'Test' ]
    thenDo: [ :logger | TinyLogger default removeLogger: logger ]
```

### List the sub-loggers

If you wish to get the list of loggers in a `TinyLogger` you can use different ways.

To get the list of all sub-loggers, you can use the `loggers` method:

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

## Record with your logger
>**TODO**
## Use another logger than the global logger
>**TODO**
