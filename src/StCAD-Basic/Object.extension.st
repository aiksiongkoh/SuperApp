Extension { #name : 'Object' }

{ #category : '*StCAD-Basic' }
Object >> changeClassToThatOf: anObject [
	"For Visualworks compatibility."

	^ self primitiveChangeClassTo: anObject
]

{ #category : '*StCAD-Basic' }
Object >> isSequenceable [

	^ false
]
