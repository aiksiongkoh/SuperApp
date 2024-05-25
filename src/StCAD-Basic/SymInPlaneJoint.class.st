Class {
	#name : 'SymInPlaneJoint',
	#superclass : 'SymJointIJ',
	#instVars : [
		'offset'
	],
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'initialize-release' }
SymInPlaneJoint >> createTranslationConstraint [

	| constraint |
	constraint := SymTranslationConstraintIJ
		              withFrmI: endFrmI
		              frmJ: endFrmJ
		              axis: 3.
	constraint aConstant: offset.
	self owns: constraint
]
