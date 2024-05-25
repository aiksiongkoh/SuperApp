Class {
	#name : 'SymPlanarJoint',
	#superclass : 'SymInPlaneJoint',
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'initialization' }
SymPlanarJoint >> initializeGlobally [

	constraints isEmpty
		ifTrue: [
			self createTranslationConstraint.
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
