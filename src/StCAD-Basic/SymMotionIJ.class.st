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

{ #category : 'initialize-release' }
SymMotionIJ >> initMotions [

	endFrmI rmemBlks: (SymFullColumn with: xBlk with: yBlk with: zBlk).
	endFrmI phiThePsiBlks: (SymFullColumn with: phiBlk with: theBlk with: psiBlk)
]

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

{ #category : 'accessing' }
SymMotionIJ >> phiBlk [

	^ phiBlk
]

{ #category : 'accessing' }
SymMotionIJ >> phiBlk: anObject [

	phiBlk := anObject
]
