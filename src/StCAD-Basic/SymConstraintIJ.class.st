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
	pGpXI := qXI ifNotNil: [ aG differentiateWRT: qXI asFullRow ].
	pGpEI := qEI ifNotNil: [ aG differentiateWRT: qEI asFullRow ].
	pGpXJ := qXJ ifNotNil: [ aG differentiateWRT: qXJ asFullRow ].
	pGpEJ := qEJ ifNotNil: [ aG differentiateWRT: qEJ asFullRow ].

	ppGptpt := pGpt differentiateWRT: t.
	ppGptpXI := qXI ifNotNil: [ pGpt differentiateWRT: qXI asFullRow ].
	ppGptpEI := qEI ifNotNil: [ pGpt differentiateWRT: qEI asFullRow ].
	ppGptpXJ := qXJ ifNotNil: [ pGpt differentiateWRT: qXJ asFullRow ].
	ppGptpEJ := qEJ ifNotNil: [ pGpt differentiateWRT: qEJ asFullRow ].

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

{ #category : 'accIC' }
SymConstraintIJ >> fillAccICVdotIterError: col [

	| vposI vposdotI vrotI vrotdotI aVrotI aVrotdotI aVvrotI vposJ vposdotJ vrotJ vrotdotJ aVrotJ aVrotdotJ aVvrotJ sum |
	endFrmI part ifNotNil: [ :partI |
			vposI := partI vpos asNumber.
			vposdotI := partI vposdot asNumber.
			vrotI := partI vrot asNumber.
			vrotdotI := partI vrotdot asNumber.
			aVrotI := partI aVrot asNumber.
			aVrotdotI := partI aVrotdot asNumber.
			aVvrotI := aVrotI timesFullColumn: vrotI ].
	endFrmJ part ifNotNil: [ :partJ |
			vposJ := partJ vpos asNumber.
			vposdotJ := partJ vposdot asNumber.
			vrotJ := partJ vrot asNumber.
			vrotdotJ := partJ vrotdot asNumber.
			aVrotJ := partJ aVrot asNumber.
			aVrotdotJ := partJ aVrotdot asNumber.
			aVvrotJ := aVrotJ timesFullColumn: vrotJ ].
	pGpXI ifNotNil: [
		col at: iqXI plusFullColumn: pGpXI asNumber times: lam ].
	pGpEI ifNotNil: [
		col at: iqEI plusFullColumn: pGpEI asNumber times: lam ].
	pGpXJ ifNotNil: [
		col at: iqXJ plusFullColumn: pGpXJ asNumber times: lam ].
	pGpEJ ifNotNil: [
		col at: iqEJ plusFullColumn: pGpEJ asNumber times: lam ].
	sum := 0.0.
	pGpXI ifNotNil: [
		sum := sum + (pGpXI asNumber timesFullColumn: vposdotI) ].
	pGpEI ifNotNil: [
			sum := sum
			       +
				       (pGpEI asNumber timesFullColumn:
					        (aVrotdotI timesFullColumn: vrotI)
					        + (aVrotI timesFullColumn: vrotdotI)) ].
	pGpXJ ifNotNil: [
		sum := sum + (pGpXJ asNumber timesFullColumn: vposdotJ) ].
	pGpEJ ifNotNil: [
			sum := sum
			       +
				       (pGpEJ asNumber timesFullColumn:
					        (aVrotdotJ timesFullColumn: vrotJ)
					        + (aVrotJ timesFullColumn: vrotdotJ)) ].
	sum := sum + ppGptpt asNumber.
	ppGptpXI ifNotNil: [
		sum := sum + (2.0 * (ppGptpXI asNumber timesFullColumn: vposI)) ].
	ppGptpEI ifNotNil: [
		sum := sum + (2.0 * (ppGptpEI asNumber timesFullColumn: aVvrotI)) ].
	ppGptpXJ ifNotNil: [
		sum := sum + (2.0 * (ppGptpXJ asNumber timesFullColumn: vposJ)) ].
	ppGptpEJ ifNotNil: [
		sum := sum + (2.0 * (ppGptpEJ asNumber timesFullColumn: aVvrotJ)) ].
	ppGpXIpXI ifNotNil: [
			sum := sum + (vposI transposeTimesFullColumn:
				        (ppGpXIpXI asNumber timesFullColumn: vposI)) ].
	ppGpXIpEI ifNotNil: [
			sum := sum + (2.0 * (vposI transposeTimesFullColumn:
				         (ppGpXIpEI asNumber timesFullColumn: aVvrotI))) ].
	ppGpXIpXJ ifNotNil: [
			sum := sum + (2.0 * (vposI transposeTimesFullColumn:
				         (ppGpXIpXJ asNumber timesFullColumn: vposJ))) ].
	ppGpXIpEJ ifNotNil: [
			sum := sum + (2.0 * (vposI transposeTimesFullColumn:
				         (ppGpXIpEJ asNumber timesFullColumn: aVvrotJ))) ].
	ppGpEIpEI ifNotNil: [
			sum := sum + (aVvrotI transposeTimesFullColumn:
				        (ppGpEIpEI asNumber timesFullColumn: aVvrotI)) ].
	ppGpEIpXJ ifNotNil: [
			sum := sum + (2.0 * (aVvrotI transposeTimesFullColumn:
				         (ppGpEIpXJ asNumber timesFullColumn: vposJ))) ].
	ppGpEIpEJ ifNotNil: [
			sum := sum + (2.0 * (aVvrotI transposeTimesFullColumn:
				         (ppGpEIpEJ asNumber timesFullColumn: aVvrotJ))) ].
	ppGpXJpXJ ifNotNil: [
			sum := sum + (vposJ transposeTimesFullColumn:
				        (ppGpXJpXJ asNumber timesFullColumn: vposJ)) ].
	ppGpXJpEJ ifNotNil: [
			sum := sum + (2.0 * (vposJ transposeTimesFullColumn:
				         (ppGpXJpEJ asNumber timesFullColumn: aVvrotJ))) ].
	ppGpEJpEJ ifNotNil: [
			sum := sum + (aVvrotJ transposeTimesFullColumn:
				        (ppGpEJpEJ asNumber timesFullColumn: aVvrotJ)) ].
	col at: iG plusNumber: sum
]

{ #category : 'as yet unclassified' }
SymConstraintIJ >> fillAccICVdotIterJacob: mat [

	| aVrotI aVrotJ |
	endFrmI part ifNotNil: [ :partI | aVrotI := partI aVrot asNumber ].
	endFrmJ part ifNotNil: [ :partJ | aVrotJ := partJ aVrot asNumber ].
	pGpXI ifNotNil: [
			| pGpXInum |
			pGpXInum := pGpXI asNumber.
			mat at: iG and: iqXI plusFullRow: pGpXInum.
			mat at: iqXI and: iG plusFullColumn: pGpXInum ].
	pGpEI ifNotNil: [
			| pGpEInum |
			pGpEInum := pGpEI asNumber.
			mat
				at: iG
				and: iqEI
				plusFullRow: (pGpEInum timesFullMatrix: aVrotI).
			mat at: iqEI and: iG plusFullColumn: pGpEInum ].
	pGpXJ ifNotNil: [
			| pGpXJnum |
			pGpXJnum := pGpXJ asNumber.
			mat at: iG and: iqXJ plusFullRow: pGpXJnum.
			mat at: iqXJ and: iG plusFullColumn: pGpXJnum ].
	pGpEJ ifNotNil: [
			| pGpEJnum |
			pGpEJnum := pGpEJ asNumber.
			mat
				at: iG
				and: iqEJ
				plusFullRow: (pGpEJnum timesFullMatrix: aVrotJ).
			mat at: iqEJ and: iG plusFullColumn: pGpEJnum ]
]

{ #category : 'posIC' }
SymConstraintIJ >> fillPosICError: col [

	super fillPosICError: col.
	iqXI ifNotNil: [ col at: iqXI plusTransposeFullRow: pGpXI asNumber times: lam ].
	iqEI ifNotNil: [ col at: iqEI plusTransposeFullRow: pGpEI asNumber times: lam ].
	iqXJ ifNotNil: [ col at: iqXJ plusTransposeFullRow: pGpXJ asNumber times: lam ].
	iqEJ ifNotNil: [ col at: iqEJ plusTransposeFullRow: pGpEJ asNumber times: lam ]
]

{ #category : 'posIC' }
SymConstraintIJ >> fillPosICJacob: mat [

	| pGpq |
	pGpXI ifNotNil: [
		pGpq := pGpXI asNumber.
		mat at: iG and: iqXI plusFullRow: pGpq.
		mat at: iqXI and: iG plusTransposeFullRow: pGpq ].
	pGpEI ifNotNil: [
		pGpq := pGpEI asNumber.
		mat at: iG and: iqEI plusFullRow: pGpq.
		mat at: iqEI and: iG plusTransposeFullRow: pGpq ].
	pGpXJ ifNotNil: [
		pGpq := pGpXJ asNumber.
		mat at: iG and: iqXJ plusFullRow: pGpq.
		mat at: iqXJ and: iG plusTransposeFullRow: pGpq ].
	pGpEJ ifNotNil: [
		pGpq := pGpEJ asNumber.
		mat at: iG and: iqEJ plusFullRow: pGpq.
		mat at: iqEJ and: iG plusTransposeFullRow: pGpq ].

	ppGpXIpXI ifNotNil: [ mat at: iqXI and: iqXI plusFullMatrix: (ppGpXIpXI asNumber times: lam) ].
	ppGpXIpEI ifNotNil: [ mat at: iqXI and: iqEI plusFullMatrix: (ppGpXIpEI asNumber times: lam) ].
	ppGpXIpXJ ifNotNil: [ mat at: iqXI and: iqXJ plusFullMatrix: (ppGpXIpXJ asNumber times: lam) ].
	ppGpXIpEJ ifNotNil: [ mat at: iqXI and: iqEJ plusFullMatrix: (ppGpXIpEJ asNumber times: lam) ].

	ppGpEIpXI ifNotNil: [ mat at: iqEI and: iqXI plusFullMatrix: (ppGpEIpXI asNumber times: lam) ].
	ppGpEIpEI ifNotNil: [ mat at: iqEI and: iqEI plusFullMatrix: (ppGpEIpEI asNumber times: lam) ].
	ppGpEIpXJ ifNotNil: [ mat at: iqEI and: iqXJ plusFullMatrix: (ppGpEIpXJ asNumber times: lam) ].
	ppGpEIpEJ ifNotNil: [ mat at: iqEI and: iqEJ plusFullMatrix: (ppGpEIpEJ asNumber times: lam) ].

	ppGpXJpXI ifNotNil: [ mat at: iqXJ and: iqXI plusFullMatrix: (ppGpXJpXI asNumber times: lam) ].
	ppGpXJpEI ifNotNil: [ mat at: iqXJ and: iqEI plusFullMatrix: (ppGpXJpEI asNumber times: lam) ].
	ppGpXJpXJ ifNotNil: [ mat at: iqXJ and: iqXJ plusFullMatrix: (ppGpXJpXJ asNumber times: lam) ].
	ppGpXJpEJ ifNotNil: [ mat at: iqXJ and: iqEJ plusFullMatrix: (ppGpXJpEJ asNumber times: lam) ].

	ppGpEJpXI ifNotNil: [ mat at: iqEJ and: iqXI plusFullMatrix: (ppGpEJpXI asNumber times: lam) ].
	ppGpEJpEI ifNotNil: [ mat at: iqEJ and: iqEI plusFullMatrix: (ppGpEJpEI asNumber times: lam) ].
	ppGpEJpXJ ifNotNil: [ mat at: iqEJ and: iqXJ plusFullMatrix: (ppGpEJpXJ asNumber times: lam) ].
	ppGpEJpEJ ifNotNil: [ mat at: iqEJ and: iqEJ plusFullMatrix: (ppGpEJpEJ asNumber times: lam) ]
]

{ #category : 'velIC' }
SymConstraintIJ >> fillVelICError: col [

	col at: iG minusNumber: pGpt asNumber
]

{ #category : 'velIC' }
SymConstraintIJ >> fillVelICJacob: mat [

	pGpXI ifNotNil: [
		| pGpq |
		pGpq := pGpXI asNumber.
		mat at: iG and: iqXI plusFullRow: pGpq.
		mat at: iqXI and: iG plusTransposeFullRow: pGpq ].
	pGpEI ifNotNil: [
		| pGpq pqdotpv pGpqtimespqdotpv |
		pGpq := pGpEI asNumber.
		pqdotpv := endFrmI pqdotpv asNumber.
		pGpqtimespqdotpv := pGpq timesFullMatrix: pqdotpv.
		mat at: iG and: iqEI plusFullRow: pGpqtimespqdotpv.
		mat at: iqEI and: iG plusFullColumn: pGpqtimespqdotpv ].
	pGpXJ ifNotNil: [
		| pGpq |
		pGpq := pGpXJ asNumber.
		mat at: iG and: iqXJ plusFullRow: pGpq.
		mat at: iqXJ and: iG plusTransposeFullRow: pGpq ].
	pGpEJ ifNotNil: [
		| pGpq pqdotpv pGpqtimespqdotpv |
		pGpq := pGpEJ asNumber.
		pqdotpv := endFrmJ pqdotpv asNumber.
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
