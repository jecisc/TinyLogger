# TinyLogger

[![Build Status](https://travis-ci.org/jecisc/TinyLogger.svg?branch=master)](https://travis-ci.org/jecisc/TinyLogger) [![Coverage Status](https://coveralls.io/repos/github/jecisc/TinyLogger/badge.svg)](https://coveralls.io/github/jecisc/TinyLogger)

A really small logger for Pharo applications.

  - [Installation](#installation)
  - [Documentation](#documentation)
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

## Documentation

Documentation is split into separate links as follows:
* [User documentation](documentation/UserGuide.md) 
* [Developer documentation](documentation/DevelopmentGuide.md)

## Version management 

This project use semantic versioning to define the releases. This means that each stable release of the project will be assigned a version number of the form `vX.Y.Z`. 

- **X** defines the major version number
- **Y** defines the minor version number 
- **Z** defines the patch version number

When a release contains only bug fixes, the patch number increases. When the release contains new features that are backward compatible, the minor version increases. When the release contains breaking changes, the major version increases. 

Thus, it should be safe to depend on a fixed major version and moving minor version of this project.

## Smalltalk versions compatibility

| MDL version 	| Compatible Pharo versions 	|
|-------------	|---------------------------	|
| 1.x.x       	| Pharo 61, 70        				|

## Contact

If you have any questions or problems do not hesitate to open an issue or contact cyril (a) ferlicot.me 
