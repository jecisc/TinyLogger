# TinyLogger

[![CI](https://github.com/jecisc/TinyLogger/actions/workflows/continuous.yml/badge.svg)](https://github.com/jecisc/TinyLogger/actions/workflows/continuous.yml) [![Coverage Status](https://coveralls.io/repos/github/jecisc/TinyLogger/badge.svg)](https://coveralls.io/github/jecisc/TinyLogger)

A really small logger for Pharo applications.

- [TinyLogger](#tinylogger)
  - [Installation](#installation)
  - [Quick start](#quick-start)
  - [Documentation](#documentation)
    - [Migration](#migration)
  - [Version management](#version-management)
  - [Smalltalk versions compatibility](#smalltalk-versions-compatibility)
  - [Contact](#contact)

## Installation

To install TinyLogger on your Pharo image, execute the following script: 

```Smalltalk
Metacello new
	githubUser: 'jecisc' project: 'TinyLogger' commitish: 'v1.x.x' path: 'src';
	baseline: 'TinyLogger';
	load
```

To add TinyLogger to your baseline:

```Smalltalk
spec
	baseline: 'TinyLogger'
	with: [ spec repository: 'github://jecisc/TinyLogger:v1.x.x/src' ]
```

Note you can replace the #master by another branch such as #development or a tag such as #v1.0.0, #v1.? or #v1.2.? .

## Quick start

To create a file logger using a file `Progress.log` and records all messages as soon as the project is loaded in a a Pharo image, in the initialize method (class side) of a project put the following:

```Smalltalk
TinyLogger default 
    addFileLoggerNamed: 'Progress.log'.
```

To create a file logger that is reset each time you run an application. Put the following in the method that is run:

```Smalltalk
TinyLogger default 
    ensureFileLoggerNamed: 'Progress.log'; "Add the file logger only if not already"
    clearLog "This will delete the previous 'Progress.log' file".
```

Then write a message to the log using `record`:

```Smalltalk
'Uh oh. Something happened.' record
```

Or write a message to the log for the execution of an action using `execute:recordedAs:`:

```Smalltalk
self execute: [ "Some code doing something" ] recordedAs: 'Launching bananas.'
```

Now, if you want to know more about the project, let's proceed on a more detailed documentation.

## Documentation

Documentation is split into separate links as follows:
* [User documentation](documentation/UserGuide.md) 
* [Developer documentation](documentation/DevelopmentGuide.md)

### Migration

- [Migrate from v1 to v2](documentation/v1toV2.md)

## Version management 

This project use semantic versioning to define the releases. This means that each stable release of the project will be assigned a version number of the form `vX.Y.Z`. 

- **X** defines the major version number
- **Y** defines the minor version number 
- **Z** defines the patch version number

When a release contains only bug fixes, the patch number increases. When the release contains new features that are backward compatible, the minor version increases. When the release contains breaking changes, the major version increases. 

Thus, it should be safe to depend on a fixed major version and moving minor version of this project.

## Smalltalk versions compatibility

| Version 	| Compatible Pharo versions    |
|-------------	|------------------------------|
| 1.x.x       	| Pharo 61, 70, 80, 90, 10, 11, 12, 13, 14 |
| 2.x.x       	| Pharo 70, 80, 90, 10, 11, 12, 13, 14 |

## Contact

If you have any questions or problems do not hesitate to open an issue or contact cyril (a) ferlicot.fr
