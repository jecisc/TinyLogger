Extension { #name : 'Object' }

{ #category : '*TinyLogger' }
Object >> execute: aBlock recordedAs: aBlockOrString [
	^ TinyCurrentLogger value execute: aBlock recordedAs: aBlockOrString
]

{ #category : '*TinyLogger' }
Object >> execute: aBlock recordedAs: aBlockOrString atLevel: aTinyLogLevel [
	^ TinyCurrentLogger value execute: aBlock recordedAs: aBlockOrString atLevel: aTinyLogLevel
]

{ #category : '*TinyLogger' }
Object >> record [
	self record: self asString
]

{ #category : '*TinyLogger' }
Object >> record: aBlockOrString [
	TinyCurrentLogger value record: aBlockOrString
]

{ #category : '*TinyLogger' }
Object >> recordAtLevel: aTinyLogLevel [
	^ TinyCurrentLogger value record: self atLevel: aTinyLogLevel
]
