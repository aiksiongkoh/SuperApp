Class {
	#name : 'SymAtPointConstraintIJ',
	#superclass : 'SymConstraintIJ',
	#instVars : [
		'axis',
		'riIeJeO'
	],
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'instance creation' }
SymAtPointConstraintIJ class >> withFrmI: eFrmI frmJ: eFrmJ axis: axis [

	^self new withFrmI: eFrmI frmJ: eFrmJ axis: axis
]

{ #category : 'as yet unclassified' }
SymAtPointConstraintIJ class >> withFrmI: eFrmI frmJ: eFrmJ frmK: eFrmK axis: axis [

	^ self new
		  withFrmI: eFrmI
		  frmJ: eFrmJ
		  frmK: eFrmK
		  axis: axis
]

{ #category : 'calc' }
SymAtPointConstraintIJ >> calcG [

	aG := riIeJeO value - aConstant
]

{ #category : 'initialization' }
SymAtPointConstraintIJ >> initialize [

	super initialize.
	riIeJeO := SymDispCompIJO new.
	riIeJeO sup: self
]

{ #category : 'initialization' }
SymAtPointConstraintIJ >> initializeGlobally [

	riIeJeO initializeGlobally
]

{ #category : 'posIC' }
SymAtPointConstraintIJ >> postInput [

	riIeJeO postInput.
	super postInput
]

{ #category : 'posIC' }
SymAtPointConstraintIJ >> prePosIC [

	riIeJeO prePosIC.
	super prePosIC
]

{ #category : 'accessing' }
SymAtPointConstraintIJ >> type [

	^ #displacement
]

{ #category : 'instance creation' }
SymAtPointConstraintIJ >> withFrmI: eFrmI frmJ: eFrmJ axis: aaxis [

	super withFrmI: eFrmI frmJ: eFrmJ.
	axis := aaxis.
	riIeJeO withFrmI: eFrmI frmJ: eFrmJ axis: aaxis
]
