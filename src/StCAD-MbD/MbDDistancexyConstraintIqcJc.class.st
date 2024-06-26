Class {
	#name : 'MbDDistancexyConstraintIqcJc',
	#superclass : 'MbDDistancexyConstraintIJ',
	#instVars : [
		'pGpXI',
		'pGpEI',
		'ppGpXIpXI',
		'ppGpXIpEI',
		'ppGpEIpEI',
		'iqXI',
		'iqEI'
	],
	#category : 'StCAD-MbD-MbDConstraint',
	#package : 'StCAD-MbD',
	#tag : 'MbDConstraint'
}

{ #category : 'VisualWorks metadata' }
MbDDistancexyConstraintIqcJc class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : 'instance creation' }
MbDDistancexyConstraintIqcJc class >> withFrmI: afrmI frmJ: afrmJ [ 
	^(afrmI isMemberOf: MbDEndFrameqc) & (afrmJ isMemberOf: MbDEndFramec) 
		ifTrue: [self new withFrmI: afrmI frmJ: afrmJ]
		ifFalse: [nil]
]

{ #category : 'accessing' }
MbDDistancexyConstraintIqcJc >> addToJointForceI: col [ 
	col equalSelfPlusFullColumn: pGpXI times: lam
]

{ #category : 'accessing' }
MbDDistancexyConstraintIqcJc >> addToJointTorqueI: jointTorque [ 
	| cForceT rIpIeIp pAOIppEI aBOIp fpAOIppEIrIpIeIp dum lampGpE c2Torque |
	cForceT := pGpXI times: lam.
	rIpIeIp := frmI rpep.
	pAOIppEI := frmI pAOppE.
	aBOIp := frmI aBOp.
	fpAOIppEIrIpIeIp := (StMFullColumn zero: 4).
	1 to: 4 do:  [:i | 
			dum := cForceT timesFullColumn: ((pAOIppEI at: i) timesFullColumn: rIpIeIp).
			fpAOIppEIrIpIeIp at: i put: dum].
	lampGpE := pGpEI transpose times: lam.
	c2Torque := aBOIp timesFullColumn: lampGpE - fpAOIppEIrIpIeIp.
	jointTorque equalSelfPlusFullColumn: c2Torque times: 0.5
]

{ #category : 'accessing' }
MbDDistancexyConstraintIqcJc >> addpFIeiGOpEIto: mat [ 
	mat equalSelfPlusFullMatrix: ppGpXIpEI times: lam
]

{ #category : 'accessing' }
MbDDistancexyConstraintIqcJc >> addpFIeiGOpXIto: mat [ 
	mat equalSelfPlusFullMatrix: ppGpXIpXI times: lam
]

{ #category : 'accessing' }
MbDDistancexyConstraintIqcJc >> addpFIeiGOplamto: mat [ 
	mat at: 1 and: iG plusFullColumn: pGpXI transpose
]

{ #category : 'accessing' }
MbDDistancexyConstraintIqcJc >> addpTIeiGOpEIto: mat [ 
	| term11 prOIeOpEIT aFIeiGOover2 term12 term1 term21 pprOIeOpEIpEI term22 pprOIeOpEIipEI term22rowi pFIeiGOpEIover2 term23 aB term2 pTIeiGOpEI |
	term11 := pGpEI transpose times: lam / 2.0.
	prOIeOpEIT := frmI prOeOpE transpose.
	aFIeiGOover2 := pGpXI transpose times: lam / 2.0.
	term12 := prOIeOpEIT timesFullColumn: aFIeiGOover2.
	term1 := MbDEulerParameters pBpEtimesColumn: (term11 minusFullColumn: term12).
	term21 := ppGpEIpEI times: lam / 2.0.
	pprOIeOpEIpEI := frmI pprOeOpEpE.
	term22 := StMFullMatrix new: 4 by: 4.
	1 to: 4
		do: 
			[:i | 
			pprOIeOpEIipEI := pprOIeOpEIpEI at: i.
			term22rowi := term22 at: i.
			1 to: 4 do: [:j | term22rowi at: j put: ((pprOIeOpEIipEI at: j)
						dot: aFIeiGOover2)]].
	pFIeiGOpEIover2 := ppGpXIpEI times: lam / 2.0.
	term23 := prOIeOpEIT timesFullMatrix: pFIeiGOpEIover2.
	aB := frmI aBOp.
	term2 := aB timesFullMatrix: ((term21 minusFullMatrix: term22)
					minusFullMatrix: term23).
	pTIeiGOpEI := term1 plusFullMatrix: term2.
	mat equalSelfPlusFullMatrix: pTIeiGOpEI
]

{ #category : 'accessing' }
MbDDistancexyConstraintIqcJc >> addpTIeiGOpXIto: mat [ 
	| aB term1 prOIeOpEIT pFIeiGOpXIover2 term2 pTIeiGOpXI |
	aB := frmI aBOp.
	term1 := ppGpXIpEI transposeTimes: lam / 2.0.
	prOIeOpEIT := frmI prOeOpE transpose.
	pFIeiGOpXIover2 := ppGpXIpXI times: lam / 2.0.
	term2 := prOIeOpEIT timesFullMatrix: pFIeiGOpXIover2.
	pTIeiGOpXI := aB timesFullMatrix: (term1 minusFullMatrix: term2).
	mat equalSelfPlusFullMatrix: pTIeiGOpXI
]

{ #category : 'accessing' }
MbDDistancexyConstraintIqcJc >> addpTIeiGOplamto: mat [ 
	| halfB term1 prOIeOpEIT pFIeiGOplam term2 pTIeiGOplam |
	halfB := frmI aBOp times: 0.5.
	term1 := pGpEI transpose.
	prOIeOpEIT := frmI prOeOpE transpose.
	pFIeiGOplam := pGpXI transpose.
	term2 := prOIeOpEIT timesFullColumn: pFIeiGOplam.
	pTIeiGOplam := halfB timesFullColumn: (term1 minusFullColumn: term2).
	mat at: 1 and: iG plusFullColumn: pTIeiGOplam
]

{ #category : 'calc' }
MbDDistancexyConstraintIqcJc >> calcPostDynCorrectorIteration [
	super calcPostDynCorrectorIteration.
	self calc_pGpXI.
	self calc_pGpEI.
	self calc_ppGpXIpXI.
	self calc_ppGpXIpEI.
	self calc_ppGpEIpEI
]

{ #category : 'calc' }
MbDDistancexyConstraintIqcJc >> calc_pGpEI [
	pGpEI := (xIeJeIe pvaluepEI times: xIeJeIe value) 
				+ (yIeJeIe pvaluepEI times: yIeJeIe value) magnifySelf: 2.0
]

{ #category : 'calc' }
MbDDistancexyConstraintIqcJc >> calc_pGpXI [
	pGpXI := (xIeJeIe pvaluepXI times: xIeJeIe value) 
				+ (yIeJeIe pvaluepXI times: yIeJeIe value) magnifySelf: 2.0
]

{ #category : 'calc' }
MbDDistancexyConstraintIqcJc >> calc_ppGpEIpEI [
	ppGpEIpEI := (xIeJeIe pvaluepEI transposeTimesFullRow: xIeJeIe pvaluepEI) 
				+ (xIeJeIe ppvaluepEIpEI times: xIeJeIe value) 
					+ (yIeJeIe pvaluepEI transposeTimesFullRow: yIeJeIe pvaluepEI) 
					+ (yIeJeIe ppvaluepEIpEI times: yIeJeIe value) magnifySelf: 2.0
]

{ #category : 'calc' }
MbDDistancexyConstraintIqcJc >> calc_ppGpXIpEI [
	ppGpXIpEI := (xIeJeIe pvaluepXI transposeTimesFullRow: xIeJeIe pvaluepEI) 
				+ (xIeJeIe ppvaluepXIpEI times: xIeJeIe value) 
					+ (yIeJeIe pvaluepXI transposeTimesFullRow: yIeJeIe pvaluepEI) 
					+ (yIeJeIe ppvaluepXIpEI times: yIeJeIe value) magnifySelf: 2.0
]

{ #category : 'calc' }
MbDDistancexyConstraintIqcJc >> calc_ppGpXIpXI [
	"xIeJeIe ppvaluepXIpXI = 0
	yIeJeIe ppvaluepXIpXI = 0"

	ppGpXIpXI := (xIeJeIe pvaluepXI transposeTimesFullRow: xIeJeIe pvaluepXI) 
				+ (yIeJeIe pvaluepXI transposeTimesFullRow: yIeJeIe pvaluepXI) 
					magnifySelf: 2.0
]

{ #category : 'accIC' }
MbDDistancexyConstraintIqcJc >> fillAccICIterError: col [ 
	| qXdotI qEdotI sum |
	col at: iqXI plusFullColumn: pGpXI times: lam.
	col at: iqEI plusFullColumn: pGpEI times: lam.
	qXdotI := frmI qXdot.
	qEdotI := frmI qEdot.
	sum := 0.0.
	sum := sum + (pGpXI timesFullColumn: frmI qXddot).
	sum := sum + (pGpEI timesFullColumn: frmI qEddot).
	sum := sum + (qXdotI transposeTimesFullColumn: (ppGpXIpXI timesFullColumn: qXdotI)).
	sum := sum + (2.0 	* (qXdotI transposeTimesFullColumn: (ppGpXIpEI timesFullColumn: qEdotI))).
	sum := sum + (qEdotI transposeTimesFullColumn: (ppGpEIpEI timesFullColumn: qEdotI)).
	col at: iG plusNumber: sum
]

{ #category : 'posIC' }
MbDDistancexyConstraintIqcJc >> fillPosICError: col [ 
	super fillPosICError: col.
	col at: iqXI plusFullColumn: pGpXI times: lam.
	col at: iqEI plusFullColumn: pGpEI times: lam
]

{ #category : 'posIC' }
MbDDistancexyConstraintIqcJc >> fillPosICJacob: mat [ 
	| ppGpXIpEIlam |
	mat at: iG and: iqXI plusFullRow: pGpXI.
	mat at: iqXI and: iG plusFullColumn: pGpXI transpose.
	mat at: iG and: iqEI plusFullRow: pGpEI.
	mat at: iqEI and: iG plusFullColumn: pGpEI transpose.
	mat at: iqXI and: iqXI plusFullMatrix: ppGpXIpXI times: lam.
	mat at: iqXI and: iqEI plusFullMatrix: (ppGpXIpEIlam := ppGpXIpEI times: lam).
	mat at: iqEI and: iqXI plusTransposeFullMatrix: ppGpXIpEIlam.
	mat at: iqEI and: iqEI plusFullMatrix: ppGpEIpEI times: lam
]

{ #category : 'posIC' }
MbDDistancexyConstraintIqcJc >> fillPosKineJacob: mat [ 
	mat
		at: iG
		and: iqXI
		plusFullRow: pGpXI.
	mat
		at: iG
		and: iqEI
		plusFullRow: pGpEI
]

{ #category : 'velIC' }
MbDDistancexyConstraintIqcJc >> fillVelICJacob: mat [ 
	mat at: iG and: iqXI plusFullRow: pGpXI.
	mat at: iqXI and: iG plusFullColumn: pGpXI transpose.
	mat at: iG and: iqEI plusFullRow: pGpEI.
	mat at: iqEI and: iG plusFullColumn: pGpEI transpose
]

{ #category : 'dynamic' }
MbDDistancexyConstraintIqcJc >> fillpFpy: mat [ 
	| ppGpXIpEIlam |
	mat at: iG and: iqXI plusFullRow: pGpXI.
	mat at: iG and: iqEI plusFullRow: pGpEI.
	mat at: iqXI and: iqXI plusFullMatrix: ppGpXIpXI times: lam.
	mat at: iqXI and: iqEI plusFullMatrix: (ppGpXIpEIlam := ppGpXIpEI times: lam).
	mat at: iqEI and: iqXI plusTransposeFullMatrix: ppGpXIpEIlam.
	mat at: iqEI and: iqEI plusFullMatrix: ppGpEIpEI times: lam.
]

{ #category : 'dynamic' }
MbDDistancexyConstraintIqcJc >> fillpFpydot: mat [ 
	mat at: iqXI and: iG plusFullColumn: pGpXI transpose.
	mat at: iqEI and: iG plusFullColumn: pGpEI transpose
]

{ #category : 'initialize-release' }
MbDDistancexyConstraintIqcJc >> useEquationNumbers [
	iqXI := frmI iqX.
	iqEI := frmI iqE
]
