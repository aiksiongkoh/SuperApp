Class {
	#name : 'SymCartesianFrame',
	#superclass : 'SymCoordinateFrame',
	#instVars : [
		'prOfOpt',
		'prOfOpX',
		'prOfOpE',
		'pprOfOptpt',
		'pprOfOptpX',
		'pprOfOptpE',
		'pprOfOpXpt',
		'pprOfOpXpX',
		'pprOfOpXpE',
		'pprOfOpEpt',
		'pprOfOpEpX',
		'pprOfOpEpE',
		'pAOfpt',
		'pAOfpX',
		'pAOfpE',
		'ppAOfptpt',
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

{ #category : 'calc' }
SymCartesianFrame >> aAOa [

	^ sup aAOa
]

{ #category : 'accessing' }
SymCartesianFrame >> aAOm [

	^ sup aAOm
]

{ #category : 'accessing' }
SymCartesianFrame >> aAOp [

	^ sup aAOp
]

{ #category : 'as yet unclassified' }
SymCartesianFrame >> calcAll [

	self calcKine.
	self calcAllrOfO.
	self calcAllaAOf
]

{ #category : 'as yet unclassified' }
SymCartesianFrame >> calcAllaAOf [

	| t qX qE block |
	t := self time.
	qX := self qX.
	qE := self qE.

	pAOfpt := aAOf differentiateWRT: t.
	pAOfpX := qX ifNotNil: [ :q | q collect: [ :qi | aAOf differentiateWRT: qi ] ].
	pAOfpE := qE ifNotNil: [ :q | q asFullColumn collect: [ :qi | aAOf differentiateWRT: qi ] ].

	ppAOfptpt := pAOfpt differentiateWRT: t.
	ppAOfptpX := qX ifNotNil: [ :q | q collect: [ :qi | pAOfpt differentiateWRT: qi ] ].
	ppAOfptpE := qE ifNotNil: [ :q | q asFullColumn collect: [ :qi | pAOfpt differentiateWRT: qi ] ].

	block := [ :qI :qJ |
	         qI ifNotNil: [ :qa |
		         qJ ifNotNil: [ :qb |
			         | m n ppAOfpapb pAOfpai ppAOfpaipbj |
			         m := qa size.
			         n := qb size.
			         ppAOfpapb := SymFullMatrix new: m by: n.
			         1 to: m do: [ :i |
				         pAOfpai := aAOf differentiateWRT: (qa at: i).
				         1 to: n do: [ :j |
					         ppAOfpaipbj := pAOfpai differentiateWRT: (qb at: j).
					         ppAOfpapb at: i and: j put: ppAOfpaipbj ] ].
			         ppAOfpapb ] ] ].

	ppAOfpXpt := pAOfpX ifNotNil: [ pAOfpX differentiateWRT: t ].
	ppAOfpXpX := block value: qX value: qX.
	ppAOfpXpE := block value: qX value: qE.

	ppAOfpEpt := pAOfpE ifNotNil: [ pAOfpE differentiateWRT: t ].
	ppAOfpEpX := block value: qE value: qX.
	ppAOfpEpE := block value: qE value: qE
]

{ #category : 'as yet unclassified' }
SymCartesianFrame >> calcAllrOfO [

	| t qX qE block |
	t := self time.
	qX := self qX.
	qE := self qE.

	block := [ :r :q |
	         q ifNotNil: [
		         | n prpq ri pripq pripqj |
		         n := q size.
		         prpq := SymFullMatrix new: 3 by: n.
		         1 to: 3 do: [ :i |
			         ri := r at: i.
			         pripq := prpq at: i.
			         1 to: n do: [ :j |
				         pripqj := ri differentiateWRT: (q at: j).
				         pripq at: j put: pripqj ] ].
		         prpq ] ].

	prOfOpt := rOfO differentiateWRT: t.
	prOfOpX := qX ifNotNil: [ block value: rOfO value: qX ].
	prOfOpE := qE ifNotNil: [ block value: rOfO value: qE ].

	pprOfOptpt := prOfOpt differentiateWRT: t.
	pprOfOptpX := qX ifNotNil: [ block value: prOfOpt value: qX ].
	pprOfOptpE := qE ifNotNil: [ block value: prOfOpt value: qE ].

	block := [ :qI :qJ |
	         qI ifNotNil: [ :qa |
		         qJ ifNotNil: [ :qb |
			         | m n pprOfOpapb prOfOpai pprOfOpaipbj |
			         m := qa size.
			         n := qb size.
			         pprOfOpapb := SymFullMatrix new: m by: n.
			         1 to: m do: [ :i |
				         prOfOpai := rOfO differentiateWRT: (qa at: i).
				         1 to: n do: [ :j |
					         pprOfOpaipbj := prOfOpai differentiateWRT: (qb at: j).
					         pprOfOpapb at: i and: j put: pprOfOpaipbj ] ].
			         pprOfOpapb ] ] ].

	pprOfOpXpt := prOfOpX ifNotNil: [ prOfOpX differentiateWRT: t ].
	pprOfOpXpX := block value: qX value: qX.
	pprOfOpXpE := block value: qX value: qE.

	pprOfOpEpt := prOfOpE ifNotNil: [ prOfOpE differentiateWRT: t ].
	pprOfOpEpX := block value: qE value: qX.
	pprOfOpEpE := block value: qE value: qE
]

{ #category : 'as yet unclassified' }
SymCartesianFrame >> calcKine [

	self subclassResponsibility
]

{ #category : 'calc' }
SymCartesianFrame >> calcPostDynCorrectorIteration [

	self halt
]

{ #category : 'accessing' }
SymCartesianFrame >> fullName [

	| stream |
	stream := WriteStream on: (String new: 256).
	self fullpath do: [ :node |
		(node respondsTo: #name) ifTrue: [
			node name isString ifTrue: [
				stream nextPut: $/.
				stream nextPutAll: node name ] ] ].
	^ stream contents
]

{ #category : 'accessing' }
SymCartesianFrame >> fullpath [

	| fullpath |
	fullpath := sup isNil
		            ifTrue: [ OrderedCollection new ]
		            ifFalse: [ sup fullpath ].
	fullpath add: self.
	^ fullpath
]

{ #category : 'accessing' }
SymCartesianFrame >> initVariables [
	"Do nothing."

	
]

{ #category : 'calc' }
SymCartesianFrame >> initialize [
	"Used to find hierarchy implementors"

	super initialize
]

{ #category : 'accessing' }
SymCartesianFrame >> iqE [

	^ sup iqE
]

{ #category : 'accessing' }
SymCartesianFrame >> iqX [

	^ sup iqX
]

{ #category : 'testing' }
SymCartesianFrame >> isPartFrame [

	^ false
]

{ #category : 'accessing' }
SymCartesianFrame >> ivE [

	^ sup ivE
]

{ #category : 'accessing' }
SymCartesianFrame >> ivOmega [

	^ sup ivOmega
]

{ #category : 'accessing' }
SymCartesianFrame >> ivX [

	^ sup ivX
]

{ #category : 'accessing' }
SymCartesianFrame >> maximumMass [

	^ sup maximumMass
]

{ #category : 'accessing' }
SymCartesianFrame >> maximumMomentOfInertia [

	^ sup maximumMomentOfInertia
]

{ #category : 'accessing' }
SymCartesianFrame >> omeOaO [

	^ sup omeOaO
]

{ #category : 'accessing' }
SymCartesianFrame >> omeOmO [

	^ sup omeOmO
]

{ #category : 'accessing' }
SymCartesianFrame >> omeOpO [

	^ sup omeOpO
]

{ #category : 'calc' }
SymCartesianFrame >> pAOapt [

	^ sup pAOapt
]

{ #category : 'accessing' }
SymCartesianFrame >> pAOmpE [

	^ sup pAOmpE
]

{ #category : 'accessing' }
SymCartesianFrame >> pAOmpt [

	^ sup pAOmpt
]

{ #category : 'accessing' }
SymCartesianFrame >> pAOppE [

	^ sup pAOppE
]

{ #category : 'accessing' }
SymCartesianFrame >> pAOppt [

	^ sup pAOppt
]

{ #category : 'accessing' }
SymCartesianFrame >> prOmOpE [

	^ sup prOmOpE
]

{ #category : 'printing' }
SymCartesianFrame >> printOn: aStream [

	aStream
		print: self class;
		nextPutAll: self fullName
]

{ #category : 'accessing' }
SymCartesianFrame >> qE [

	^ sup qE
]

{ #category : 'accessing' }
SymCartesianFrame >> qX [

	^ sup qX
]

{ #category : 'accessing' }
SymCartesianFrame >> rOaO [

	^ sup rOaO
]

{ #category : 'accessing' }
SymCartesianFrame >> rOmO [

	^ sup rOmO
]

{ #category : 'accessing' }
SymCartesianFrame >> rOpO [

	^ sup rOpO
]

{ #category : 'accessing' }
SymCartesianFrame >> sup: frm [
	"Used to find hierarchy implementors"

	super sup: frm.
	self
		initVariables;
		calcAll
]

{ #category : 'accessing' }
SymCartesianFrame >> time [

	^ sup time
]

{ #category : 'accessing' }
SymCartesianFrame >> vOaO [

	^ sup vOaO
]

{ #category : 'accessing' }
SymCartesianFrame >> vOmO [

	^ sup vOmO
]

{ #category : 'accessing' }
SymCartesianFrame >> vOpO [

	^ sup vOpO
]
