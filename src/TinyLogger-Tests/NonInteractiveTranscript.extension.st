Extension { #name : #NonInteractiveTranscript }

{ #category : #'*TinyLogger-Tests' }
NonInteractiveTranscript >> contents [
	1halt.
	^ self stream contents
]
