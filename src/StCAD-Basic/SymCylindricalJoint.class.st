Class {
	#name : 'SymCylindricalJoint',
	#superclass : 'SymInLineJoint',
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'initialization' }
SymCylindricalJoint >> initializeGlobally [

	constraints isEmpty
		ifTrue: [
			self createInLineConstraints.
			self owns: (SymDirectionCosineConstraintIJ
					 withFrmI: endFrmI
					 frmJ: endFrmJ
					 axisI: 3
					 axisJ: 1).
			self owns: (SymDirectionCosineConstraintIJ
					 withFrmI: endFrmI
					 frmJ: endFrmJ
					 axisI: 3
					 axisJ: 2).
			self hasChanged: true ]
		ifFalse: [ super initializeGlobally ]
]
