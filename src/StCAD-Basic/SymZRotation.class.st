Class {
	#name : 'SymZRotation',
	#superclass : 'SymMotionIJ',
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'initialization' }
SymZRotation >> initializeGlobally [

	constraints isEmpty
		ifTrue: [
			self initMotions.
			self owns: (SymDirectionCosineConstraintIJ
					 withFrmI: endFrmI
					 frmJ: endFrmJ
					 axisI: 2
					 axisJ: 1).
			self hasChanged: true ]
		ifFalse: [ super initializeGlobally ]
]
