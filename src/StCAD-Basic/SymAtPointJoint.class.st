Class {
	#name : 'SymAtPointJoint',
	#superclass : 'SymJointIJ',
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'initialization' }
SymAtPointJoint >> createAtPointConstraints [

	self owns:
		(SymAtPointConstraintIJ withFrmI: endFrmI frmJ: endFrmJ axis: 1).
	self owns:
		(SymAtPointConstraintIJ withFrmI: endFrmI frmJ: endFrmJ axis: 2).
	self owns:
		(SymAtPointConstraintIJ withFrmI: endFrmI frmJ: endFrmJ axis: 3)
]
