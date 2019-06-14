# Developer documentation

This page will cover the developer documentation. It is recomanded to read the [user documentation](UserGuide.md) before this guide.

A first part will cover the design of the project and a second part will be a tutorial to add a new leaf logger.

- [Developer documentation](#developer-documentation)
  * [Design](#design)
  * [TinyCurrentLogger dynamic variable](#tinycurrentlogger-dynamic-variable)
  * [Add a new leaf transcript](#add-a-new-leaf-transcript)

## Design

![UML of the project](uml.png?raw=true "UML of the project")

`TinyLogger` project is based on the (Composite design pattern)[https://en.wikipedia.org/wiki/Composite_pattern]. The logger to used, instance of `TinyLogger` is a composite containing `TinyLeafLogger`s. 

To add a new logger kind, `TinyLeafLogger` needs to be overriden.

## TinyCurrentLogger dynamic variable

To record logs, the user will use extension methods implemented on `Object` as the main API. The `Object` will recover the `TinyLogger`'s instance to use to record the log via a DynamicVariable called `TinyCurrentLogger` like this:

```Smalltalk
 Object>>execute: aBlock recordedAs: aString
	TinyCurrentLogger value execute: aBlock recordedAs: aString
```

The `TinyCurrentLogger` has a default value that is the default instance of `TinyLogger`. This value can be changed using the `value:during:` message as explained in the user documentation.

## Add a new leaf transcript

In this section we will add a new leaf logger recording logs in a remote server via a HTTP request on a REST API.

The first step is to create a subclass of `TinyLeafLogger`. If we want to make the URL to post on customizable, we need a variable `url`.

```Smalltalk
TinyLeafLogger subclass: #TinyHTTPLogger
	slots: { #url }
	classVariables: {  }
	package: 'CustomLogger'
```

Generates the accessors for the `url` variable and you can add a constructor:

```Smalltalk
TinyHTTPLogger class>>url: aString
	^ self new
		url: aString;
		yourself
```

Since `TinyLogger` groups its loggers by kinds, you need to define a `kind` method on the class side.

```Smalltalk
 TinyHTTPLogger class>>kind
	^ 'HTTP'
```

Next step is to define the `record:` method to actually write the log. The superclass manages the preamble and formating directly via the method `record:on:` that needs to be called in your `record:` method. 

```Smalltalk
TinyHTTPLogger>>record: aString
	ZnEasy post: self url data: (String streamContents: [ :s | self record: aString on: s ])
```

At this point, our new logger is usable. You can add a new instance to your `TinyLogger` this way:

```Smalltalk
TinyLogger default addLogger: (TinyHTTPLogger url: 'http://localhost:1234/api/logger')
```

But I recommand to add some suggar to the `TinyLogger` class with extension methods.

The first one is to create and add a new HTTP logger:

```Smalltalk
TinyLogger>>addHTTPLogger: aString
	self addLogger: (TinyHTTPLogger url: aString)
```

The logger can now be used like this:

```Smalltalk
TinyLogger default addHTTPLogger: 'http://localhost:1234/api/logger'
```

Another method to add as extension is a method to get all the HTTP loggers:

```Smalltalk
TinyLogger>>httpLoggers
	^ self loggersMap at: TinyHTTPLogger kind ifAbsentPut: [ OrderedCollection new ]
```

Now that we have `httpLoggers`, we can easily add an `ensureHTTPLogger:` method matching `addHTTPLogger:`:

```Smalltalk
TinyLogger>>ensureHTTPLogger: aString
	self httpLoggers
		detect: [ :e | e url = aString ]
		ifNone: [ self addHTTPLogger: aString ]
```

And the last method to add as extension will be used to remove all HTTP loggers of the logger:

```Smalltalk
 TinyLogger>>removeHTTPLoggers
	self httpLoggers removeAll
```

One last method to implement is `clearLogger` to clean the previous logs if the user want it:

```Smalltalk
TinyHTTPLogger>>record: aString
	ZnClient new
		beOneShot;
		url: self url;
		delete
```

At this point you have one new logger kind available!
