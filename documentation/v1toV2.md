# Migration guide v1 to v2

Between the v1 and v2 some things changed.

## Drop P6 compatibility

V2 does not work anymore with Pharo 6 and 6.1. If your project is on Pharo 6, keep using the version 1 of TinyLogger.

## Cannot add a logger created from #for:

In the past it was possible to do:

```Smalltalk
TinyLogger default addLogger: (TinyTranscriptLogger for: TinyLogger default)
```

Now this does not work anymore because #`for:` is now adding itself to the parameter. If you still do this, yu will end up with the logger duplicated. 

You can now do:

```Smalltalk
TinyLogger default addLogger: TinyTranscriptLogger new
```

or:

```Smalltalk
TinyLogger default addTrascriptLogger "or ensureTranscriptLogger"
```

## Removal of the leading space before colon

In v1 the timestamp was followed by a space before the colon.

Like this:

```
2018-11-29T23:19:55.511775+01:00 : This is a string to log
```

In the v2 this was removed. If you want this space, you can add it the the #`timestampFormatBlock:`.

```Smalltalk
TinyLogger default timestampFormatBlock: [ :aStream :timestamp | aStream << timestamp asString << ' ' ]
```


## Option execution block indentation

In the past, using `#execute:recordedAs:` was adding some extra indentation like this:

```Smalltalk
self execute: [ 'Log' record ] recordedAs: 'Task'
```

```
2018-11-29T23:21:04.897775+01:00: 	Begin: Task
2018-11-29T23:21:04.900775+01:00: 		Log
2018-11-29T23:21:04.909775+01:00: 	End: Task
```

Now it prints like this:

```
2018-11-29T23:21:04.897775+01:00: Begin: Task
2018-11-29T23:21:04.900775+01:00: 	Log
2018-11-29T23:21:04.909775+01:00: End: Task
```

In order to get the previous behavior you can use `#indentExecutionBlock:` like this:

```Smalltalk
TinyLogger default indentExecutionBlock: true
```
