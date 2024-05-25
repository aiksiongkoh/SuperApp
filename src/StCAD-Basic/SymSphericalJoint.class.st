Class {
	#name : 'SymSphericalJoint',
	#superclass : 'SymAtPointJoint',
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'initialization' }
SymSphericalJoint >> initializeGlobally [

	constraints isEmpty
		ifTrue: [
			self createAtPointConstraints.
			self hasChanged: true ]
		ifFalse: [ super initializeGlobally ]
]
