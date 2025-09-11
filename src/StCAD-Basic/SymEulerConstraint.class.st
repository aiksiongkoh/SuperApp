Class {
	#name : 'SymEulerConstraint',
	#superclass : 'SymConstraint',
	#instVars : [
		'pGpE',
		'iqE',
		'ppGpEpE',
		'ivE'
	],
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'VisualWorks metadata' }
SymEulerConstraint class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : 'ops' }
SymEulerConstraint >> assignVelICEqnNum: eqnNo [

	self halt: 'Check this'.
	^ (sup isKindOf: SymPartFrameXEVOme)
		  ifTrue: [ "Euler parameter constraint gives null VelIC equation."
				  self iG: nil.
				  ^ eqnNo ]
		  ifFalse: [ super assignVelICEqnNum: eqnNo ]
]

{ #category : 'calc' }
SymEulerConstraint >> calcAll [

	| qErow |
	super calcAll.
	qErow := sup qE asFullRow.
	pGpE := aG differentiateWRT: qErow.
	ppGpEpE := pGpE differentiateWRT: qErow
]

{ #category : 'calc' }
SymEulerConstraint >> calcG [

	aG := sup qE sumOfSquares - 1.0
]

{ #category : 'calc' }
SymEulerConstraint >> calcPostDynCorrectorIteration [

	| qE |
	self halt.
	qE := sup qE.
	aG := qE sumOfSquares - 1.0.
	1 to: 4 do: [ :i | pGpE at: i put: 2.0 * (qE at: i) ]
]

{ #category : 'accessing' }
SymEulerConstraint >> classString [
	"Used to access the descriptive name of the constraint."
	"Needed for multi-language."

	^TheMbDSystem getString: #'MbD: Euler constraint '
]

{ #category : 'accIC' }
SymEulerConstraint >> fillAccICIterError: col [
	"qdotT[ppGpqpq]*qdot."

	"qdotT[2 2 2 2 diag]*qdot."

	| sum |
	col at: iqE plusFullColumn: pGpE times: lam.
	sum := 0.0.
	sum := sum + (pGpE timesFullColumn: self qEddot).
	sum := sum + (2.0 * self qEdot sumOfSquares).
	col at: iG plusNumber: sum
]

{ #category : 'as yet unclassified' }
SymEulerConstraint >> fillAccICVdotIterError: col [
	"
	""qdotT[ppGpqpq]*qdot.""
	""qdotT[2 2 2 2 diag]*qdot.""

	| sum |
	col at: iqE plusFullColumn: pGpE times: lam.
	sum := 0.0d.
	sum := sum + (pGpE timesFullColumn: owner qEddot).
	sum := sum + (2.0d * owner qEdot sumOfSquares).
	col at: iG plusNumber: sum
"

	| part v vdot aV aVdot aVv pGpEnum sum |
	part := self part.
	v := part vrot asNumber.
	vdot := part vrotdot asNumber.
	aV := part aVrot asNumber.
	aVdot := part aVrotdot asNumber.
	aVv := aV timesFullColumn: v.
	pGpEnum := pGpE asNumber.
	col at: iqE plusFullColumn: pGpEnum times: lam.
	sum := 0.0.
	sum := sum + (pGpEnum timesFullColumn:
		        (aVdot timesFullColumn: v) + (aV timesFullColumn: vdot)).
	sum := sum
	       +
	       (aVv transposeTimesFullColumn:
		        (ppGpEpE asNumber timesFullColumn: aVv)).
	col at: iG plusNumber: sum
]

{ #category : 'collision' }
SymEulerConstraint >> fillCollisionError: col [
	"lamDeriv is now PlamDeriv."

	"qEddot is now qEdotDeriv."

	| sum |
	col at: iqE plusFullColumn: pGpE times: lamDeriv.
	sum := 0.0.
	sum := sum + (pGpE timesFullColumn: sup qEddot).
	col at: iG plusNumber: sum
]

{ #category : 'posIC' }
SymEulerConstraint >> fillPosICError: col [

	super fillPosICError: col.
	col at: iqE plusTransposeFullRow: pGpE asNumber times: lam
]

{ #category : 'posIC' }
SymEulerConstraint >> fillPosICJacob: mat [

	| pGpq |
	pGpE ifNotNil: [
		pGpq := pGpE asNumber.
		mat at: iG and: iqE plusFullRow: pGpq.
		mat at: iqE and: iG plusTransposeFullRow: pGpq ].

	ppGpEpE ifNotNil: [ mat at: iqE and: iqE plusFullMatrix: (ppGpEpE asNumber times: lam) ]
]

{ #category : 'posIC' }
SymEulerConstraint >> fillPosKineJacob: mat [ 
	mat
		at: iG
		and: iqE
		plusFullRow: pGpE
]

{ #category : 'velIC' }
SymEulerConstraint >> fillVelICJacob: mat [

	| pGpq pqdotpv pGpqtimespqdotpv |
	(sup isKindOf: SymPartFrameXEVOme)
		ifTrue: [ "Euler parameter constraint gives null VelIC equation." ]
		ifFalse: [
			pGpq := pGpE asNumber.
			pqdotpv := sup pqdotpv asNumber.
			pGpqtimespqdotpv := pGpq timesFullMatrix: pqdotpv.
			mat at: iG and: iqE plusFullRow: pGpqtimespqdotpv.
			mat at: iqE and: iG plusTransposeFullRow: pGpqtimespqdotpv ]
]

{ #category : 'dynamic' }
SymEulerConstraint >> fillpFpy: mat [ 
	"ppGpEpE is a diag(2,2,2,2)."

	| ioffset twolam i |
	mat at: iG and: iqE plusFullRow: pGpE.
	ioffset := iqE - 1.
	twolam := 2.0 * lam.
	1 to: 4 do: [:ii | 
			i := ioffset + ii.
			mat at: i and: i plusNumber: twolam]
]

{ #category : 'dynamic' }
SymEulerConstraint >> fillpFpydot: mat [ 
	mat at: iqE and: iG plusFullColumn: pGpE transpose
]

{ #category : 'initialize-release' }
SymEulerConstraint >> initialize [
	super initialize.
	pGpE := StMFullRow new: 4
]

{ #category : 'accessing' }
SymEulerConstraint >> pGpE [
	^pGpE
]

{ #category : 'initialize-release' }
SymEulerConstraint >> useEquationNumbers [

	iqE := sup iqE
]

{ #category : 'initialize-release' }
SymEulerConstraint >> useVelICEqnNo [

	ivE := sup ivE
]
