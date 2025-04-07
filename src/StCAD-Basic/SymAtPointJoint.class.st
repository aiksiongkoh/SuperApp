Class {
	#name : 'SymAtPointJoint',
	#superclass : 'SymJointIJ',
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'initialize - release' }
SymAtPointJoint >> connectsI: mkrII toJ: mkrJJ [

	super connectsI: mkrII toJ: mkrJJ.
	self addConstraint: (SymAtPointConstraintIJ withFrmI: endFrmI frmJ: endFrmJ axis: 1).
	self addConstraint: (SymAtPointConstraintIJ withFrmI: endFrmI frmJ: endFrmJ axis: 2).
	self addConstraint: (SymAtPointConstraintIJ withFrmI: endFrmI frmJ: endFrmJ axis: 3)
]

{ #category : 'initialization' }
SymAtPointJoint >> createAtPointConstraints [

	self addConstraint: (SymAtPointConstraintIJ withFrmI: endFrmI frmJ: endFrmJ axis: 1).
	self addConstraint: (SymAtPointConstraintIJ withFrmI: endFrmI frmJ: endFrmJ axis: 2).
	self addConstraint: (SymAtPointConstraintIJ withFrmI: endFrmI frmJ: endFrmJ axis: 3)
]
