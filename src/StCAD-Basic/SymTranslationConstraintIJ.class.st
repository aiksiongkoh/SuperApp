Class {
	#name : 'SymTranslationConstraintIJ',
	#superclass : 'SymConstraintIJ',
	#instVars : [
		'riIeJeIe',
		'axis'
	],
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'instance creation' }
SymTranslationConstraintIJ class >> withFrmI: eFrmI frmJ: eFrmJ axis: axis [

	^ self new withFrmI: eFrmI frmJ: eFrmJ axis: axis
]

{ #category : 'calc' }
SymTranslationConstraintIJ >> calcG [

	aG := riIeJeIe value - aConstant
]

{ #category : 'initialization' }
SymTranslationConstraintIJ >> initialize [

	super initialize.
	riIeJeIe := SymDispCompIJI new.
	riIeJeIe sup: self
]

{ #category : 'posIC' }
SymTranslationConstraintIJ >> postInput [

	riIeJeIe postInput.
	super postInput
]

{ #category : 'posIC' }
SymTranslationConstraintIJ >> prePosIC [

	riIeJeIe prePosIC.
	super prePosIC
]

{ #category : 'accessing' }
SymTranslationConstraintIJ >> type [

	^ #displacement
]

{ #category : 'instance creation' }
SymTranslationConstraintIJ >> withFrmI: eFrmI frmJ: eFrmJ axis: aaxis [

	super withFrmI: eFrmI frmJ: eFrmJ.
	axis := aaxis.
	riIeJeIe withFrmI: eFrmI frmJ: eFrmJ axis: aaxis
]
