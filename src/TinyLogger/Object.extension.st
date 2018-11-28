Extension { #name : #Object }

{ #category : #'*TinyLogger' }
Object >> execute: aBlock recordedAs: aString [
	TinyCurrentLogger value execute: aBlock recordedAs: aString
]

{ #category : #'*TinyLogger' }
Object >> record [
	self record: self asString
]

{ #category : #'*TinyLogger' }
Object >> record: aString [
	TinyCurrentLogger value record: aString
]
