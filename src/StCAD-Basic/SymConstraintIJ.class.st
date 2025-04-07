Class {
	#name : 'SymConstraintIJ',
	#superclass : 'SymConstraint',
	#instVars : [
		'endFrmI',
		'endFrmJ',
		'aConstant',
		'iqXI',
		'iqEI',
		'iqXJ',
		'iqEJ',
		'pGpEI',
		'pGpEJ',
		'pGpXI',
		'pGpXJ',
		'pGpt',
		'ppGpEIpEI',
		'ppGpEIpEJ',
		'ppGpEIpXJ',
		'ppGpEIpt',
		'ppGpEJpEJ',
		'ppGpEJpt',
		'ppGpXIpEI',
		'ppGpXIpEJ',
		'ppGpXIpXI',
		'ppGptpt',
		'ppGpXJpt',
		'ppGpXJpXJ',
		'ppGpXJpEJ',
		'ppGpXIpXJ',
		'ppGpXIpt',
		'ppGptpXI',
		'ppGptpEI',
		'ppGptpXJ',
		'ppGptpEJ',
		'ppGpEIpXI',
		'ppGpXJpXI',
		'ppGpXJpEI',
		'ppGpEJpXI',
		'ppGpEJpEI',
		'ppGpEJpXJ',
		'ivXI',
		'ivEI',
		'ivXJ',
		'ivEJ'
	],
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'calc' }
SymConstraintIJ >> calcAll [

	| t qXI qEI qXJ qEJ block |
	super calcAll.

	t := endFrmI time.
	qXI := endFrmI qX.
	qEI := endFrmI qE.
	qXJ := endFrmJ qX.
	qEJ := endFrmJ qE.

	pGpt := aG differentiateWRT: t.
	pGpXI := qXI ifNotNil: [ :q | q asFullRow collect: [ :qi | aG differentiateWRT: qi ] ].
	pGpEI := qEI ifNotNil: [ :q | q asFullRow collect: [ :qi | aG differentiateWRT: qi ] ].
	pGpXJ := qXJ ifNotNil: [ :q | q asFullRow collect: [ :qi | aG differentiateWRT: qi ] ].
	pGpEJ := qEJ ifNotNil: [ :q | q asFullRow collect: [ :qi | aG differentiateWRT: qi ] ].

	ppGptpt := pGpt differentiateWRT: t.
	ppGptpXI := qXI ifNotNil: [ :q | q asFullRow collect: [ :qi | pGpt differentiateWRT: qi ] ].
	ppGptpEI := qEI ifNotNil: [ :q | q asFullRow collect: [ :qi | pGpt differentiateWRT: qi ] ].
	ppGptpXJ := qXJ ifNotNil: [ :q | q asFullRow collect: [ :qi | pGpt differentiateWRT: qi ] ].
	ppGptpEJ := qEJ ifNotNil: [ :q | q asFullRow collect: [ :qi | pGpt differentiateWRT: qi ] ].

	block := [ :qI :qJ |
	         qI ifNotNil: [ :qa |
		         qJ ifNotNil: [ :qb |
			         | m n ppGpapb pGpai ppGpaipbj |
			         m := qa size.
			         n := qb size.
			         ppGpapb := SymFullMatrix new: m by: n.
			         1 to: m do: [ :i |
				         pGpai := aG differentiateWRT: (qa at: i).
				         1 to: n do: [ :j |
					         ppGpaipbj := pGpai differentiateWRT: (qb at: j).
					         ppGpapb at: i and: j put: ppGpaipbj ] ].
			         ppGpapb ] ] ].

	ppGpXIpt := pGpXI ifNotNil: [ pGpXI differentiateWRT: t ].
	ppGpXIpXI := block value: qXI value: qXI.
	ppGpXIpEI := block value: qXI value: qEI.
	ppGpXIpXJ := block value: qXI value: qXJ.
	ppGpXIpEJ := block value: qXI value: qEJ.

	ppGpEIpt := pGpEI ifNotNil: [ pGpEI differentiateWRT: t ].
	ppGpEIpXI := block value: qEI value: qXI.
	ppGpEIpEI := block value: qEI value: qEI.
	ppGpEIpXJ := block value: qEI value: qXJ.
	ppGpEIpEJ := block value: qEI value: qEJ.

	ppGpXJpt := pGpXJ ifNotNil: [ pGpXJ differentiateWRT: t ].
	ppGpXJpXI := block value: qXJ value: qXI.
	ppGpXJpEI := block value: qXJ value: qEI.
	ppGpXJpXJ := block value: qXJ value: qXJ.
	ppGpXJpEJ := block value: qXJ value: qEJ.

	ppGpEJpt := pGpEJ ifNotNil: [ pGpEJ differentiateWRT: t ].
	ppGpEJpXI := block value: qEJ value: qXI.
	ppGpEJpEI := block value: qEJ value: qEI.
	ppGpEJpXJ := block value: qEJ value: qXJ.
	ppGpEJpEJ := block value: qEJ value: qEJ
]

{ #category : 'accIC' }
SymConstraintIJ >> fillAccICIterError: col [

	| qXdotI qEdotI qXdotJ qEdotJ sum |
	pGpXI ifNotNil: [ col at: iqXI plusFullColumn: pGpXI times: lam ].
	pGpEI ifNotNil: [ col at: iqEI plusFullColumn: pGpEI times: lam ].
	pGpXJ ifNotNil: [ col at: iqXJ plusFullColumn: pGpXJ times: lam ].
	pGpEJ ifNotNil: [ col at: iqEJ plusFullColumn: pGpEJ times: lam ].
	qXdotI := endFrmI qXdot.
	qEdotI := endFrmI qEdot.
	qXdotJ := endFrmJ qXdot.
	qEdotJ := endFrmJ qEdot.
	sum := 0.0.
	pGpXI ifNotNil: [ sum := sum + (pGpXI timesFullColumn: endFrmI qXddot) ].
	pGpEI ifNotNil: [ sum := sum + (pGpEI timesFullColumn: endFrmI qEddot) ].
	pGpXJ ifNotNil: [ sum := sum + (pGpXJ timesFullColumn: endFrmJ qXddot) ].
	pGpEJ ifNotNil: [ sum := sum + (pGpEJ timesFullColumn: endFrmJ qEddot) ].
	sum := sum + ppGptpt.
	ppGptpXI ifNotNil: [ sum := sum + (2.0 * (ppGptpXI timesFullColumn: qXdotI)) ].
	ppGptpEI ifNotNil: [ sum := sum + (2.0 * (ppGptpEI timesFullColumn: qEdotI)) ].
	ppGptpXJ ifNotNil: [ sum := sum + (2.0 * (ppGptpXJ timesFullColumn: qXdotJ)) ].
	ppGptpEJ ifNotNil: [ sum := sum + (2.0 * (ppGptpEJ timesFullColumn: qEdotJ)) ].
	ppGpXIpXI ifNotNil: [
		sum := sum + (qXdotI transposeTimesFullColumn: (ppGpXIpXI timesFullColumn: qXdotI)) ].
	ppGpXIpEI ifNotNil: [
		sum := sum + (2.0 * (qXdotI transposeTimesFullColumn: (ppGpXIpEI timesFullColumn: qEdotI))) ].
	ppGpXIpXJ ifNotNil: [
		sum := sum + (2.0 * (qXdotI transposeTimesFullColumn: (ppGpXIpXJ timesFullColumn: qXdotJ))) ].
	ppGpXIpEJ ifNotNil: [
		sum := sum + (2.0 * (qXdotI transposeTimesFullColumn: (ppGpXIpEJ timesFullColumn: qEdotJ))) ].
	ppGpEIpEI ifNotNil: [
		sum := sum + (qEdotI transposeTimesFullColumn: (ppGpEIpEI timesFullColumn: qEdotI)) ].
	ppGpEIpXJ ifNotNil: [
		sum := sum + (2.0 * (qEdotI transposeTimesFullColumn: (ppGpEIpXJ timesFullColumn: qXdotJ))) ].
	ppGpEIpEJ ifNotNil: [
		sum := sum + (2.0 * (qEdotI transposeTimesFullColumn: (ppGpEIpEJ timesFullColumn: qEdotJ))) ].
	ppGpXJpXJ ifNotNil: [
		sum := sum + (qXdotJ transposeTimesFullColumn: (ppGpXJpXJ timesFullColumn: qXdotJ)) ].
	ppGpXJpEJ ifNotNil: [
		sum := sum + (2.0 * (qXdotJ transposeTimesFullColumn: (ppGpXJpEJ timesFullColumn: qEdotJ))) ].
	ppGpEJpEJ ifNotNil: [
		sum := sum + (qEdotJ transposeTimesFullColumn: (ppGpEJpEJ timesFullColumn: qEdotJ)) ].
	col at: iG plusNumber: sum
]

{ #category : 'posIC' }
SymConstraintIJ >> fillPosICError: col [

	super fillPosICError: col.
	iqXI ifNotNil: [ col at: iqXI plusTransposeFullRow: pGpXI asValue times: lam ].
	iqEI ifNotNil: [ col at: iqEI plusTransposeFullRow: pGpEI asValue times: lam ].
	iqXJ ifNotNil: [ col at: iqXJ plusTransposeFullRow: pGpXJ asValue times: lam ].
	iqEJ ifNotNil: [ col at: iqEJ plusTransposeFullRow: pGpEJ asValue times: lam ]
]

{ #category : 'posIC' }
SymConstraintIJ >> fillPosICJacob: mat [

	| pGpq |
	pGpXI ifNotNil: [
		pGpq := pGpXI asValue.
		mat at: iG and: iqXI plusFullRow: pGpq.
		mat at: iqXI and: iG plusTransposeFullRow: pGpq ].
	pGpEI ifNotNil: [
		pGpq := pGpEI asValue.
		mat at: iG and: iqEI plusFullRow: pGpq.
		mat at: iqEI and: iG plusTransposeFullRow: pGpq ].
	pGpXJ ifNotNil: [
		pGpq := pGpXJ asValue.
		mat at: iG and: iqXJ plusFullRow: pGpq.
		mat at: iqXJ and: iG plusTransposeFullRow: pGpq ].
	pGpEJ ifNotNil: [
		pGpq := pGpEJ asValue.
		mat at: iG and: iqEJ plusFullRow: pGpq.
		mat at: iqEJ and: iG plusTransposeFullRow: pGpq ].

	ppGpXIpXI ifNotNil: [ mat at: iqXI and: iqXI plusFullMatrix: (ppGpXIpXI asValue times: lam) ].
	ppGpXIpEI ifNotNil: [ mat at: iqXI and: iqEI plusFullMatrix: (ppGpXIpEI asValue times: lam) ].
	ppGpXIpXJ ifNotNil: [ mat at: iqXI and: iqXJ plusFullMatrix: (ppGpXIpXJ asValue times: lam) ].
	ppGpXIpEJ ifNotNil: [ mat at: iqXI and: iqEJ plusFullMatrix: (ppGpXIpEJ asValue times: lam) ].

	ppGpEIpXI ifNotNil: [ mat at: iqEI and: iqXI plusFullMatrix: (ppGpEIpXI asValue times: lam) ].
	ppGpEIpEI ifNotNil: [ mat at: iqEI and: iqEI plusFullMatrix: (ppGpEIpEI asValue times: lam) ].
	ppGpEIpXJ ifNotNil: [ mat at: iqEI and: iqXJ plusFullMatrix: (ppGpEIpXJ asValue times: lam) ].
	ppGpEIpEJ ifNotNil: [ mat at: iqEI and: iqEJ plusFullMatrix: (ppGpEIpEJ asValue times: lam) ].

	ppGpXJpXI ifNotNil: [ mat at: iqXJ and: iqXI plusFullMatrix: (ppGpXJpXI asValue times: lam) ].
	ppGpXJpEI ifNotNil: [ mat at: iqXJ and: iqEI plusFullMatrix: (ppGpXJpEI asValue times: lam) ].
	ppGpXJpXJ ifNotNil: [ mat at: iqXJ and: iqXJ plusFullMatrix: (ppGpXJpXJ asValue times: lam) ].
	ppGpXJpEJ ifNotNil: [ mat at: iqXJ and: iqEJ plusFullMatrix: (ppGpXJpEJ asValue times: lam) ].

	ppGpEJpXI ifNotNil: [ mat at: iqEJ and: iqXI plusFullMatrix: (ppGpEJpXI asValue times: lam) ].
	ppGpEJpEI ifNotNil: [ mat at: iqEJ and: iqEI plusFullMatrix: (ppGpEJpEI asValue times: lam) ].
	ppGpEJpXJ ifNotNil: [ mat at: iqEJ and: iqXJ plusFullMatrix: (ppGpEJpXJ asValue times: lam) ].
	ppGpEJpEJ ifNotNil: [ mat at: iqEJ and: iqEJ plusFullMatrix: (ppGpEJpEJ asValue times: lam) ]
]

{ #category : 'velIC' }
SymConstraintIJ >> fillVelICError: col [

	col at: iG minusNumber: pGpt asValue
]

{ #category : 'velIC' }
SymConstraintIJ >> fillVelICJacob: mat [

	pGpXI ifNotNil: [
		| pGpq |
		pGpq := pGpXI asValue.
		mat at: iG and: iqXI plusFullRow: pGpq.
		mat at: iqXI and: iG plusTransposeFullRow: pGpq ].
	pGpEI ifNotNil: [
		| pGpq pqdotpv pGpqtimespqdotpv |
		pGpq := pGpEI asValue.
		pqdotpv := endFrmI pqdotpv asValue.
		pGpqtimespqdotpv := pGpq timesFullMatrix: pqdotpv.
		mat at: iG and: iqEI plusFullRow: pGpqtimespqdotpv.
		mat at: iqEI and: iG plusFullColumn: pGpqtimespqdotpv ].
	pGpXJ ifNotNil: [
		| pGpq |
		pGpq := pGpXJ asValue.
		mat at: iG and: iqXJ plusFullRow: pGpq.
		mat at: iqXJ and: iG plusTransposeFullRow: pGpq ].
	pGpEJ ifNotNil: [
		| pGpq pqdotpv pGpqtimespqdotpv |
		pGpq := pGpEJ asValue.
		pqdotpv := endFrmJ pqdotpv asValue.
		pGpqtimespqdotpv := pGpq timesFullMatrix: pqdotpv.
		mat at: iG and: iqEJ plusFullRow: pGpqtimespqdotpv.
		mat at: iqEJ and: iG plusFullColumn: pGpqtimespqdotpv ]
]

{ #category : 'initialization' }
SymConstraintIJ >> initialize [

	super initialize.
	aConstant := 0.0
]

{ #category : 'initialize-release' }
SymConstraintIJ >> useEquationNumbers [

	iqXI := endFrmI iqX.
	iqEI := endFrmI iqE.
	iqXJ := endFrmJ iqX.
	iqEJ := endFrmJ iqE
]

{ #category : 'initialize-release' }
SymConstraintIJ >> useVelICEqnNo [

	ivXI := endFrmI ivX.
	ivEI := endFrmI ivE.
	ivXJ := endFrmJ ivX.
	ivEJ := endFrmJ ivE
]

{ #category : 'instance creation' }
SymConstraintIJ >> withFrmI: eFrmI frmJ: eFrmJ [

	endFrmI := eFrmI.
	endFrmJ := eFrmJ
]
