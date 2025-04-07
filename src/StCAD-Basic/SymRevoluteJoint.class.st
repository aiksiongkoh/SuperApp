Class {
	#name : 'SymRevoluteJoint',
	#superclass : 'SymAtPointJoint',
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'initialize - release' }
SymRevoluteJoint >> connectsI: mkrII toJ: mkrJJ [

	super connectsI: mkrII toJ: mkrJJ.
	self addConstraint: (SymDirectionCosineConstraintIJ
			 withFrmI: endFrmI
			 frmJ: endFrmJ
			 axisI: 3
			 axisJ: 1).
	self addConstraint: (SymDirectionCosineConstraintIJ
			 withFrmI: endFrmI
			 frmJ: endFrmJ
			 axisI: 3
			 axisJ: 2)
]

{ #category : 'initialization' }
SymRevoluteJoint >> initializeGlobally [

	constraints isEmpty
		ifTrue: [
			self createAtPointConstraints.
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
