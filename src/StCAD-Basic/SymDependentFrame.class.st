Class {
	#name : 'SymDependentFrame',
	#superclass : 'SymCartesianFrame',
	#instVars : [
		'prOfOpX',
		'prOfOpE',
		'pprOfOptpX',
		'pprOfOptpE',
		'pprOfOpXpt',
		'pprOfOpXpX',
		'pprOfOpXpE',
		'pprOfOpEpt',
		'pprOfOpEpX',
		'pprOfOpEpE',
		'pAOfpX',
		'pAOfpE',
		'ppAOfptpX',
		'ppAOfptpE',
		'ppAOfpXpt',
		'ppAOfpXpX',
		'ppAOfpXpE',
		'ppAOfpEpt',
		'ppAOfpEpX',
		'ppAOfpEpE'
	],
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'accessing' }
SymDependentFrame >> aAOm [

	^ sup aAOm
]

{ #category : 'accessing' }
SymDependentFrame >> aAOp [

	^ sup aAOp
]

{ #category : 'as yet unclassified' }
SymDependentFrame >> calcAllaAOf [

	| t qX qE block |
	super calcAllaAOf.
	t := self time.
	qX := self qX.
	qE := self qE.

	pAOfpX := qX collect: [ :qi | aAOf differentiateWRT: qi ].
	pAOfpE := qE asFullColumn collect: [ :qi | aAOf differentiateWRT: qi ].

	ppAOfptpX := qX collect: [ :qi | pAOfpt differentiateWRT: qi ].
	ppAOfptpE := qE asFullColumn collect: [ :qi |
		             pAOfpt differentiateWRT: qi ].

	block := [ :qa :qb |
		         | m n ppAOfpapb pAOfpai ppAOfpaipbj |
		         m := qa size.
		         n := qb size.
		         ppAOfpapb := SymFullMatrix new: m by: n.
		         1 to: m do: [ :i |
				         pAOfpai := aAOf differentiateWRT: (qa at: i).
				         1 to: n do: [ :j |
						         ppAOfpaipbj := pAOfpai differentiateWRT: (qb at: j).
						         ppAOfpapb at: i and: j put: ppAOfpaipbj ] ].
		         ppAOfpapb ].

	ppAOfpXpt := pAOfpX differentiateWRT: t.
	ppAOfpXpX := block value: qX value: qX.
	ppAOfpXpE := block value: qX value: qE.

	ppAOfpEpt := pAOfpE differentiateWRT: t.
	ppAOfpEpX := block value: qE value: qX.
	ppAOfpEpE := block value: qE value: qE
]

{ #category : 'as yet unclassified' }
SymDependentFrame >> calcAllrOfO [

	| t qX qE block |
	super calcAllrOfO.
	t := self time.
	qX := self qX.
	qE := self qE.

	block := [ :r :q |
		         | n prpq ri pripq pripqj |
		         n := q size.
		         prpq := SymFullMatrix new: 3 by: n.
		         1 to: 3 do: [ :i |
				         ri := r at: i.
				         pripq := prpq at: i.
				         1 to: n do: [ :j |
						         pripqj := ri differentiateWRT: (q at: j).
						         pripq at: j put: pripqj simplified ] ].
		         prpq ].

	prOfOpX := block value: rOfO value: qX.
	prOfOpE := block value: rOfO value: qE.

	pprOfOptpX := block value: prOfOpt value: qX.
	pprOfOptpE := block value: prOfOpt value: qE.

	block := [ :qa :qb |
		         | m n pprOfOpapb prOfOpai pprOfOpaipbj |
		         m := qa size.
		         n := qb size.
		         pprOfOpapb := SymFullMatrix new: m by: n.
		         1 to: m do: [ :i |
				         prOfOpai := (rOfO differentiateWRT: (qa at: i))
					                     simplified.
				         1 to: n do: [ :j |
						         pprOfOpaipbj := prOfOpai differentiateWRT: (qb at: j).
						         pprOfOpapb at: i and: j put: pprOfOpaipbj simplified ] ].
		         pprOfOpapb ].

	pprOfOpXpt := (prOfOpX differentiateWRT: t) simplified.
	pprOfOpXpX := block value: qX value: qX.
	pprOfOpXpE := block value: qX value: qE.

	pprOfOpEpt := (prOfOpE differentiateWRT: t) simplified.
	pprOfOpEpX := block value: qE value: qX.
	pprOfOpEpE := block value: qE value: qE
]

{ #category : 'calc' }
SymDependentFrame >> calcPostDynCorrectorIteration [

	self halt
]

{ #category : 'accessing' }
SymDependentFrame >> initVariables [

	self subclassResponsibility
]

{ #category : 'calc' }
SymDependentFrame >> initialize [
	"Used to find hierarchy implementors"

	super initialize
]

{ #category : 'accessing' }
SymDependentFrame >> iqE [

	^ sup iqE
]

{ #category : 'accessing' }
SymDependentFrame >> iqX [

	^ sup iqX
]

{ #category : 'accessing' }
SymDependentFrame >> ivE [

	^ sup ivE
]

{ #category : 'accessing' }
SymDependentFrame >> ivOmega [

	^ sup ivOmega
]

{ #category : 'accessing' }
SymDependentFrame >> ivX [

	^ sup ivX
]

{ #category : 'accessing' }
SymDependentFrame >> maximumMass [

	^ sup maximumMass
]

{ #category : 'accessing' }
SymDependentFrame >> maximumMomentOfInertia [

	^ sup maximumMomentOfInertia
]

{ #category : 'accessing' }
SymDependentFrame >> omeOaO [

	^ sup omeOaO
]

{ #category : 'accessing' }
SymDependentFrame >> omeOmO [

	^ sup omeOmO
]

{ #category : 'accessing' }
SymDependentFrame >> omeOpO [

	^ sup omeOpO
]

{ #category : 'accessing' }
SymDependentFrame >> omedotOaO [

	^ sup omedotOaO
]

{ #category : 'calc' }
SymDependentFrame >> pAOapt [

	^ sup pAOapt
]

{ #category : 'accessing' }
SymDependentFrame >> pAOmpE [

	^ sup pAOmpE
]

{ #category : 'accessing' }
SymDependentFrame >> pAOmpt [

	^ sup pAOmpt
]

{ #category : 'accessing' }
SymDependentFrame >> pAOppE [

	^ sup pAOppE
]

{ #category : 'accessing' }
SymDependentFrame >> pAOppt [

	^ sup pAOppt
]

{ #category : 'accessing' }
SymDependentFrame >> prOmOpE [

	^ sup prOmOpE
]

{ #category : 'printing' }
SymDependentFrame >> printOn: aStream [

	aStream
		print: self class;
		nextPutAll: self fullName
]

{ #category : 'accessing' }
SymDependentFrame >> qE [

	^ sup qE
]

{ #category : 'accessing' }
SymDependentFrame >> qX [

	^ sup qX
]

{ #category : 'accessing' }
SymDependentFrame >> rOmO [

	^ sup rOmO
]

{ #category : 'accessing' }
SymDependentFrame >> rOpO [

	^ sup rOpO
]

{ #category : 'accessing' }
SymDependentFrame >> time [

	^ sup time
]

{ #category : 'accessing' }
SymDependentFrame >> vOaO [

	^ sup vOaO
]

{ #category : 'accessing' }
SymDependentFrame >> vOmO [

	^ sup vOmO
]

{ #category : 'accessing' }
SymDependentFrame >> vOpO [

	^ sup vOpO
]

{ #category : 'accessing' }
SymDependentFrame >> vdotOaO [

	^ sup vdotOaO
]
