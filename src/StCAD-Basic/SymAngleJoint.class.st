Class {
	#name : 'SymAngleJoint',
	#superclass : 'SymJointIJ',
	#instVars : [
		'theIzJz'
	],
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'initialization' }
SymAngleJoint >> initializeGlobally [

	| constraint |
	constraints isEmpty
		ifTrue: [
			constraint := SymDirectionCosineConstraintIJ
				              withFrmI: endFrmI
				              frmJ: endFrmJ
				              axisI: 3
				              axisJ: 3.
			constraint aConstant: theIzJz cos.
			self owns: constraint.
			self hasChanged: true ]
		ifFalse: [ super initializeGlobally ]
]
