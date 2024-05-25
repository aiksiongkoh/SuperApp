Class {
	#name : 'SymInLineJoint',
	#superclass : 'SymJointIJ',
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'as yet unclassified' }
SymInLineJoint >> createInLineConstraints [

	self owns:
		(SymTranslationConstraintIJ withFrmI: endFrmI frmJ: endFrmJ axis: 1).
	self owns:
		(SymTranslationConstraintIJ withFrmI: endFrmI frmJ: endFrmJ axis: 2)
]
