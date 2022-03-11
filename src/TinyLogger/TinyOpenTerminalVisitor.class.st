Class {
	#name : #TinyOpenTerminalVisitor,
	#superclass : #OSPlatformVisitor,
	#instVars : [
		'logger'
	],
	#category : #'TinyLogger-System'
}

{ #category : #'as yet unclassified' }
TinyOpenTerminalVisitor class >> openTerminalForFileLogger: aTinyFileLogger [

	^ self new
		  logger: aTinyFileLogger;
		  visit
]

{ #category : #accessing }
TinyOpenTerminalVisitor >> logger [

	^ logger
]

{ #category : #accessing }
TinyOpenTerminalVisitor >> logger: anObject [

	logger := anObject
]

{ #category : #accessing }
TinyOpenTerminalVisitor >> visitWindows: aPlatform [

	LibC runCommand:
		'start powershell -noexit -noprofil -command "& { Get-Content -wait '
		, self logger fileReference pathString , ' }"'
]
