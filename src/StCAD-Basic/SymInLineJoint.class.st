Class {
	#name : 'SymInLineJoint',
	#superclass : 'SymJointIJ',
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'initialize-release' }
SymInLineJoint >> connectsI: mkrII toJ: mkrJJ [

	super connectsI: mkrII toJ: mkrJJ.
	self addConstraint: (SymTranslationConstraintIJ withFrmI: endFrmI frmJ: endFrmJ axis: 1).
	self addConstraint: (SymTranslationConstraintIJ withFrmI: endFrmI frmJ: endFrmJ axis: 2)
]

{ #category : 'as yet unclassified' }
SymInLineJoint >> createInLineConstraints [

	self addConstraint:
		(SymTranslationConstraintIJ withFrmI: endFrmI frmJ: endFrmJ axis: 1).
	self addConstraint:
		(SymTranslationConstraintIJ withFrmI: endFrmI frmJ: endFrmJ axis: 2)
]
