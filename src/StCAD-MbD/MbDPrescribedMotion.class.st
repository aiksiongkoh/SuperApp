Class {
	#name : 'MbDPrescribedMotion',
	#superclass : 'MbDJoint',
	#instVars : [
		'xBlk',
		'yBlk',
		'zBlk',
		'phiBlk',
		'theBlk',
		'psiBlk'
	],
	#category : 'StCAD-MbD-MbDMotion',
	#package : 'StCAD-MbD',
	#tag : 'MbDMotion'
}

{ #category : 'VisualWorks metadata' }
MbDPrescribedMotion class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : 'initialize-release' }
MbDPrescribedMotion >> connectsI: mkrII toJ: mkrJJ [ 
	| eFrmqct |
	super connectsI: mkrII toJ: mkrJJ.
	(frmI isMemberOf: MbDEndFrameqct) 
		ifFalse: 
			[eFrmqct := MbDEndFrameqct new.
			eFrmqct name: frmI name.
			eFrmqct markerFrame: frmI markerFrame.
			frmI become: eFrmqct]
]

{ #category : 'accessing' }
MbDPrescribedMotion >> fillDispConstraints: collection [ 
	"Prescribed constraints are essential."
	"Do nothing."
]

{ #category : 'accessing' }
MbDPrescribedMotion >> fillEssenConstraints: collection [ 
	constraints do: [:con | con fillEssenConstraints: collection]
]

{ #category : 'accessing' }
MbDPrescribedMotion >> fillPerpenConstraints: collection [ 
	"Prescribed constraints are essential."
	"Do nothing."
]

{ #category : 'initialize-release' }
MbDPrescribedMotion >> initMotions [
	frmI rmemBlks: (StMFullColumn with: xBlk with: yBlk with: zBlk).
	frmI phiThePsiBlks: (StMFullColumn with: phiBlk with: theBlk with: psiBlk)
]

{ #category : 'initialize-release' }
MbDPrescribedMotion >> initialize [
	super initialize.
	xBlk := StMConstant with: 0.
	yBlk := StMConstant with: 0.
	zBlk := StMConstant with: 0.
	phiBlk := StMConstant with: 0.
	theBlk := StMConstant with: 0.
	psiBlk := StMConstant with: 0
]

{ #category : 'accessing' }
MbDPrescribedMotion >> phiBlk: block [ 
	phiBlk := block
]

{ #category : 'accessing' }
MbDPrescribedMotion >> psiBlk: block [ 
	psiBlk := block
]

{ #category : 'accessing' }
MbDPrescribedMotion >> theBlk: block [ 
	theBlk := block
]

{ #category : 'accessing' }
MbDPrescribedMotion >> xBlk: block [ 
	xBlk := block
]

{ #category : 'accessing' }
MbDPrescribedMotion >> yBlk: block [ 
	yBlk := block
]

{ #category : 'accessing' }
MbDPrescribedMotion >> zBlk: block [ 
	zBlk := block
]
