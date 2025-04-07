Class {
	#name : 'SymDirectionCosineConstraintIJ',
	#superclass : 'SymConstraintIJ',
	#instVars : [
		'axisI',
		'axisJ',
		'aAijIeJe'
	],
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'instance creation' }
SymDirectionCosineConstraintIJ class >> withFrmI: eFrmI frmJ: eFrmJ axisI: axisI axisJ: axisJ [

	^ self new
		  withFrmI: eFrmI
		  frmJ: eFrmJ
		  axisI: axisI
		  axisJ: axisJ
]

{ #category : 'calc' }
SymDirectionCosineConstraintIJ >> calcG [

	aAijIeJe calcAll.
	aG := aAijIeJe value - aConstant
]

{ #category : 'calc' }
SymDirectionCosineConstraintIJ >> calcPostDynCorrectorIteration [

	self halt.
	aG := aAijIeJe aAijIeJe - aConstant
]

{ #category : 'initialization' }
SymDirectionCosineConstraintIJ >> initialize [

	super initialize.
	aAijIeJe := SymDirectionCosineIJ new.
	aAijIeJe sup: self
]

{ #category : 'accessing' }
SymDirectionCosineConstraintIJ >> type [

	^ #perpendicular
]

{ #category : 'instance creation' }
SymDirectionCosineConstraintIJ >> withFrmI: eFrmI frmJ: eFrmJ axisI: aaxisI axisJ: aaxisJ [

	super withFrmI: eFrmI frmJ: eFrmJ.
	axisI := aaxisI.
	axisJ := aaxisJ.
	aAijIeJe
		withFrmI: eFrmI
		frmJ: eFrmJ
		axisI: aaxisI
		axisJ: aaxisJ
]
