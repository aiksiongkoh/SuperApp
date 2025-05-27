Extension { #name : 'Stream' }

{ #category : '*StMath' }
Stream >> skipThrough: anObject [
	"Skip forward to the occurrence of anObject.
	 Leaves positioned after anObject. 
	If the object is not found the stream is positioned at the end and nil is returned."

	[self atEnd ifTrue: [^nil].
	self next = anObject ifTrue: [^self]] repeat
]
