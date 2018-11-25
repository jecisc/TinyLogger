Extension { #name : #Object }

{ #category : #'*TinyLogger' }
Object >> execute: aBlock recordedAs: aString [
	TinyLogger default execute: aBlock recordedAs: aString
]

{ #category : #'*TinyLogger' }
Object >> record [
	self record: self asString
]

{ #category : #'*TinyLogger' }
Object >> record: aString [
	TinyLogger default record: aString
]
