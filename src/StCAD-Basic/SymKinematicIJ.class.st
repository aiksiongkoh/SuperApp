Class {
	#name : 'SymKinematicIJ',
	#superclass : 'SymItemIJ',
	#instVars : [
		'kineIJ',
		'pkineIJpXI',
		'pkineIJpEI',
		'ppkineIJpXIpEI',
		'ppkineIJpEIpEI',
		'pkineIJpXJ',
		'pkineIJpEJ',
		'ppkineIJpEIpXJ',
		'ppkineIJpEIpEJ',
		'ppkineIJpEJpEJ',
		'pkineIJpt',
		'ppkineIJpXIpt',
		'ppkineIJpEIpt',
		'ppkineIJpXJpt',
		'ppkineIJpEJpt',
		'ppkineIJptpt',
		'ppkineIJpXIpXI',
		'ppkineIJpXIpXJ',
		'ppkineIJpXIpEJ',
		'ppkineIJpXJpXJ',
		'ppkineIJpXJpEJ',
		'ppkineIJpEIpXI',
		'ppkineIJpXJpEI',
		'ppkineIJpXJpXI',
		'ppkineIJpEJpEI',
		'ppkineIJpEJpXI',
		'ppkineIJpEJpXJ',
		'ppkineIJptpEI',
		'ppkineIJptpEJ',
		'ppkineIJptpXI',
		'ppkineIJptpXJ'
	],
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'calc' }
SymKinematicIJ >> calcAll [

	| t qXI qEI qXJ qEJ block |
	self calcKineIJ.

	t := endFrmI time.
	qXI := endFrmI qX.
	qEI := endFrmI qE.
	qXJ := endFrmJ qX.
	qEJ := endFrmJ qE.

	pkineIJpt := kineIJ differentiateWRT: t.
	pkineIJpXI := qXI ifNotNil: [ kineIJ differentiateWRT: qXI ].
	pkineIJpEI := qEI ifNotNil: [
		              kineIJ differentiateWRT: qEI asFullColumn ].
	pkineIJpXJ := qXJ ifNotNil: [ kineIJ differentiateWRT: qXJ ].
	pkineIJpEJ := qEJ ifNotNil: [
		              kineIJ differentiateWRT: qEJ asFullColumn ].

	ppkineIJptpt := pkineIJpt differentiateWRT: t.
	ppkineIJptpXI := qXI ifNotNil: [ pkineIJpt differentiateWRT: qXI ].
	ppkineIJptpEI := qEI ifNotNil: [
		                 pkineIJpt differentiateWRT: qEI asFullColumn ].
	ppkineIJptpXJ := qXJ ifNotNil: [ pkineIJpt differentiateWRT: qXJ ].
	ppkineIJptpEJ := qEJ ifNotNil: [
		                 pkineIJpt differentiateWRT: qEJ asFullColumn ].

	block := [ :qI :qJ |
		         qI ifNotNil: [ :qa |
				         qJ ifNotNil: [ :qb |
						         | m n ppkineIJpapb pkineIJpai ppkineIJpaipbj |
						         m := qa size.
						         n := qb size.
						         ppkineIJpapb := SymFullMatrix new: m by: n.
						         1 to: m do: [ :i |
								         pkineIJpai := kineIJ differentiateWRT: (qa at: i).
								         1 to: n do: [ :j |
										         ppkineIJpaipbj := pkineIJpai differentiateWRT:
											                           (qb at: j).
										         ppkineIJpapb at: i and: j put: ppkineIJpaipbj ] ].
						         ppkineIJpapb ] ] ].

	ppkineIJpXIpt := pkineIJpXI ifNotNil: [
		                 pkineIJpXI differentiateWRT: t ].
	ppkineIJpXIpXI := block value: qXI value: qXI.
	ppkineIJpXIpEI := block value: qXI value: qEI.
	ppkineIJpXIpXJ := block value: qXI value: qXJ.
	ppkineIJpXIpEJ := block value: qXI value: qEJ.

	ppkineIJpEIpt := pkineIJpEI ifNotNil: [
		                 pkineIJpEI differentiateWRT: t ].
	ppkineIJpEIpXI := block value: qEI value: qXI.
	ppkineIJpEIpEI := block value: qEI value: qEI.
	ppkineIJpEIpXJ := block value: qEI value: qXJ.
	ppkineIJpEIpEJ := block value: qEI value: qEJ.

	ppkineIJpXJpt := pkineIJpXJ ifNotNil: [
		                 pkineIJpXJ differentiateWRT: t ].
	ppkineIJpXJpXI := block value: qXJ value: qXI.
	ppkineIJpXJpEI := block value: qXJ value: qEI.
	ppkineIJpXJpXJ := block value: qXJ value: qXJ.
	ppkineIJpXJpEJ := block value: qXJ value: qEJ.

	ppkineIJpEJpt := pkineIJpEJ ifNotNil: [
		                 pkineIJpEJ differentiateWRT: t ].
	ppkineIJpEJpXI := block value: qEJ value: qXI.
	ppkineIJpEJpEI := block value: qEJ value: qEI.
	ppkineIJpEJpXJ := block value: qEJ value: qXJ.
	ppkineIJpEJpEJ := block value: qEJ value: qEJ
]

{ #category : 'as yet unclassified' }
SymKinematicIJ >> calcKineIJ [

	self subclassResponsibility
]

{ #category : 'initialization' }
SymKinematicIJ >> initializeGlobally [
	"Do nothing."

	
]

{ #category : 'evaluating' }
SymKinematicIJ >> ppvaluepEIpEI [

	^ ppkineIJpEIpEI
]

{ #category : 'evaluating' }
SymKinematicIJ >> ppvaluepEIpEJ [

	^ ppkineIJpEIpEJ
]

{ #category : 'evaluating' }
SymKinematicIJ >> ppvaluepEIpXI [

	^ ppkineIJpEIpXI
]

{ #category : 'evaluating' }
SymKinematicIJ >> ppvaluepEIpXJ [

	^ ppkineIJpEIpXJ
]

{ #category : 'evaluating' }
SymKinematicIJ >> ppvaluepEIpt [

	^ ppkineIJpEIpt
]

{ #category : 'evaluating' }
SymKinematicIJ >> ppvaluepEJpEI [

	^ ppkineIJpEJpEI
]

{ #category : 'evaluating' }
SymKinematicIJ >> ppvaluepEJpEJ [

	^ ppkineIJpEJpEJ
]

{ #category : 'evaluating' }
SymKinematicIJ >> ppvaluepEJpXI [

	^ ppkineIJpEJpXI
]

{ #category : 'evaluating' }
SymKinematicIJ >> ppvaluepEJpXJ [

	^ ppkineIJpEJpXJ
]

{ #category : 'evaluating' }
SymKinematicIJ >> ppvaluepEJpt [

	^ ppkineIJpEJpt
]

{ #category : 'evaluating' }
SymKinematicIJ >> ppvaluepXIpEI [

	^ ppkineIJpXIpEI
]

{ #category : 'evaluating' }
SymKinematicIJ >> ppvaluepXIpEJ [

	^ ppkineIJpXIpEJ
]

{ #category : 'evaluating' }
SymKinematicIJ >> ppvaluepXIpXI [

	^ ppkineIJpXIpXI
]

{ #category : 'evaluating' }
SymKinematicIJ >> ppvaluepXIpXJ [

	^ ppkineIJpXIpXJ
]

{ #category : 'evaluating' }
SymKinematicIJ >> ppvaluepXIpt [

	^ ppkineIJpXIpt
]

{ #category : 'evaluating' }
SymKinematicIJ >> ppvaluepXJpEI [

	^ ppkineIJpXJpEI
]

{ #category : 'evaluating' }
SymKinematicIJ >> ppvaluepXJpEJ [

	^ ppkineIJpXJpEJ
]

{ #category : 'evaluating' }
SymKinematicIJ >> ppvaluepXJpXI [

	^ ppkineIJpXJpXI
]

{ #category : 'evaluating' }
SymKinematicIJ >> ppvaluepXJpXJ [

	^ ppkineIJpXJpXJ
]

{ #category : 'evaluating' }
SymKinematicIJ >> ppvaluepXJpt [

	^ ppkineIJpXJpt
]

{ #category : 'evaluating' }
SymKinematicIJ >> ppvalueptpEI [

	^ ppkineIJptpEI
]

{ #category : 'evaluating' }
SymKinematicIJ >> ppvalueptpEJ [

	^ ppkineIJptpEJ
]

{ #category : 'evaluating' }
SymKinematicIJ >> ppvalueptpXI [

	^ ppkineIJptpXI
]

{ #category : 'evaluating' }
SymKinematicIJ >> ppvalueptpXJ [

	^ ppkineIJptpXJ
]

{ #category : 'evaluating' }
SymKinematicIJ >> ppvalueptpt [

	^ ppkineIJptpt
]

{ #category : 'evaluating' }
SymKinematicIJ >> pvaluepEI [

	^ pkineIJpEI
]

{ #category : 'evaluating' }
SymKinematicIJ >> pvaluepEJ [

	^ pkineIJpEJ
]

{ #category : 'evaluating' }
SymKinematicIJ >> pvaluepXI [

	^ pkineIJpXI
]

{ #category : 'evaluating' }
SymKinematicIJ >> pvaluepXJ [

	^ pkineIJpXJ
]

{ #category : 'evaluating' }
SymKinematicIJ >> value [

	^ kineIJ
]
