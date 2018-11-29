# TinyLogger

[![Build Status](https://travis-ci.org/jecisc/TinyLogger.svg?branch=master)](https://travis-ci.org/jecisc/TinyLogger) [![Coverage Status](https://coveralls.io/repos/github/jecisc/TinyLogger/badge.svg)](https://coveralls.io/github/jecisc/TinyLogger)

A really small logger for Pharo application.

  - [Installation](#installation)
  - [Documentation](#documentation)
  - [Version management](#version-management)
  - [Smalltalk versions compatibility](#smalltalk-versions-compatibility)
  - [Contact](#contact)

## Installation

To install TinyLogger on your Pharo image you can just execute the following script: 

```Smalltalk
Metacello new
	githubUser: 'jecisc' project: 'TinyLogger' commitish: 'v1.x.x' path: 'src';
	baseline: 'TinyLogger';
	load
```

To add TinyLogger to your baseline just add this:

```Smalltalk
spec
	baseline: 'TinyLogger'
	with: [ spec repository: 'github://jecisc/TinyLogger:v1.x.x/src' ]
```

Note that you can replace the #master by another branch as #development or a tag as #v1.0.0, #v1.? or #v1.2.? .

## Documentation

You can find documentation following those links:
* [User documentation](documentation/UserGuide.md) 
* [Developer documentation](documentation/DevelopmentGuide.md)

## Version management 

This project use semantic versionning to define the releases. This mean that each stable release of the project will get associate a version number of the form `vX.Y.Z`. 

- **X** define the major version number
- **Y** define the minor version number 
- **Z** define the patch version number

When a release contains only bug fixes, the patch number increase. When the release contains new features backward compatibles, the minor version increase. When the release contains breaking changes, the major version increase. 

Thus, it should be safe to depend on a fixed major version and moving minor version of this project.

## Smalltalk versions compatibility

| MDL version 	| Compatible Pharo versions 	|
|-------------	|---------------------------	|
| 1.x.x       	| Pharo 61, 70        				|

## Contact

If you have any question or problem do not hesitate to open an issue or contact cyril (a) ferlicot.me 
