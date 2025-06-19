Extension { #name : 'Object' }

{ #category : '*TinyLogger' }
Object >> execute: aBlock recordedAs: aBlockOrString [
	^ TinyCurrentLogger value execute: aBlock recordedAs: aBlockOrString
]

{ #category : '*TinyLogger' }
Object >> record [
	self record: self asString
]

{ #category : '*TinyLogger' }
Object >> record: aBlockOrString [
	TinyCurrentLogger value record: aBlockOrString
]
