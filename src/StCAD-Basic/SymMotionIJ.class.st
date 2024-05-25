Class {
	#name : 'SymMotionIJ',
	#superclass : 'SymConstraintSetIJ',
	#instVars : [
		'xBlk',
		'yBlk',
		'zBlk',
		'phiBlk',
		'theBlk',
		'psiBlk'
	],
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'initialization' }
SymMotionIJ >> initialize [

	super initialize.
	xBlk := StMConstant with: 0.
	yBlk := StMConstant with: 0.
	zBlk := StMConstant with: 0.
	phiBlk := StMConstant with: 0.
	theBlk := StMConstant with: 0.
	psiBlk := StMConstant with: 0
]
