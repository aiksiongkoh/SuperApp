Class {
	#name : 'SymMarkerFrame',
	#superclass : 'SymCartesianFrame',
	#instVars : [
		'rOmO',
		'aAOm',
		'omeOmO',
		'aApm',
		'rpmp',
		'thepm',
		'vOmO'
	],
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'accessing' }
SymMarkerFrame >> aAOm [

	^ aAOm
]

{ #category : 'accessing' }
SymMarkerFrame >> aApm [

	^ aApm
]

{ #category : 'adding' }
SymMarkerFrame >> addEndFC: aStEndFrameCurve [

	subs add: aStEndFrameCurve.
	aStEndFrameCurve sup: self
]

{ #category : 'adding' }
SymMarkerFrame >> addEndFS: aStEndFrameSurface [

	subs add: aStEndFrameSurface.
	aStEndFrameSurface sup: self
]

{ #category : 'adding' }
SymMarkerFrame >> addEndFc: aStEndFramec [

	subs add: aStEndFramec.
	aStEndFramec sup: self
]

{ #category : 'adding' }
SymMarkerFrame >> addEndFrm: endFrm [

	subs add: endFrm.
	endFrm sup: self
]

{ #category : 'adding' }
SymMarkerFrame >> addEndFrmC: endFrmC [

	subs add: endFrmC.
	endFrmC sup: self
]

{ #category : 'adding' }
SymMarkerFrame >> addEndFrmS: endFrmS [

	subs add: endFrmS.
	endFrmS sup: self
]

{ #category : 'adding' }
SymMarkerFrame >> addEndFrmc: endFrmc [

	subs add: endFrmc.
	endFrmc sup: self
]

{ #category : 'adding' }
SymMarkerFrame >> addEndFrmt: endFrmt [

	subs add: endFrmt.
	endFrmt sup: self
]

{ #category : 'adding' }
SymMarkerFrame >> addEndFt: aStEndFramet [

	subs add: aStEndFramet.
	aStEndFramet sup: self
]

{ #category : 'ops' }
SymMarkerFrame >> assignVelICEqnNum: i [

	| eqnNo |
	eqnNo := i.
	subs do: [ :eFrm | eqnNo := eFrm assignVelICEqnNum: eqnNo ].
	^ eqnNo
]

{ #category : 'as yet unclassified' }
SymMarkerFrame >> calcAllKE [
	"Do nothing."

]

{ #category : 'accessing' }
SymMarkerFrame >> calcKine [

	rOmO := (self rOpO + (self aAOp timesFullColumn: rpmp)) simplified.
	aAOm := (self aAOp timesFullMatrix: aApm) simplified.
	rOfO := rOmO.
	aAOf := aAOm
]

{ #category : 'as yet unclassified' }
SymMarkerFrame >> endFrms [

	^ subs
]

{ #category : 'as yet unclassified' }
SymMarkerFrame >> fillAccICVdotIterError: col [
	"Do nothing."

	
]

{ #category : 'accessing' }
SymMarkerFrame >> fillContactEndFrames: collection [

	subs do: [ :eFrm | eFrm fillContactEndFrames: collection ]
]

{ #category : 'accessing' }
SymMarkerFrame >> fillPosICError: col [

	subs do: [ :eFrm | eFrm fillPosICError: col ]
]

{ #category : 'accessing' }
SymMarkerFrame >> fillPosICJacob: mat [

	subs do: [ :eFrm | eFrm fillPosICJacob: mat ]
]

{ #category : 'accessing' }
SymMarkerFrame >> fillVelICError: col [

	subs do: [ :eFrm | eFrm fillVelICError: col ]
]

{ #category : 'accessing' }
SymMarkerFrame >> fillVelICJacob: mat [

	subs do: [ :eFrm | eFrm fillVelICJacob: mat ]
]

{ #category : 'accessing' }
SymMarkerFrame >> fillVelICWeights: col [

	subs do: [ :eFrm | eFrm fillVelICWeights: col ]
]

{ #category : 'accessing' }
SymMarkerFrame >> fillqsu: col [

	subs do: [ :eFrm | eFrm fillqsu: col ]
]

{ #category : 'accessing' }
SymMarkerFrame >> fillqsuWeights: col [

	subs do: [ :eFrm | eFrm fillqsuWeights: col ]
]

{ #category : 'accessing' }
SymMarkerFrame >> fillqsuddotlam: col [

	subs do: [ :eFrm | eFrm fillqsuddotlam: col ]
]

{ #category : 'accessing' }
SymMarkerFrame >> fillqsudot: col [

	subs do: [ :eFrm | eFrm fillqsudot: col ]
]

{ #category : 'vel' }
SymMarkerFrame >> fillqsudotWeights: col [

	subs do: [ :eFrm | eFrm fillqsudotWeights: col ]
]

{ #category : 'accessing' }
SymMarkerFrame >> fillqsulam: col [

	subs do: [ :eFrm | eFrm fillqsulam: col ]
]

{ #category : 'initialization' }
SymMarkerFrame >> initVariables [

	| t block selffullName |
	t := self time.
	rpmp do: [ :r | r x: t ].
	thepm do: [ :the | the x: t ].
	selffullName := self fullName.
	block := [ :var |
	         | fullName |
	         fullName := String new writeStream
		                     nextPutAll: selffullName;
		                     nextPut: $/;
		                     nextPutAll: var name;
		                     contents.
	         var name: fullName asSymbol ].
	rpmp do: block.
	thepm do: block
]

{ #category : 'initialization' }
SymMarkerFrame >> initialize [

	| rpmp1 rpmp2 rpmp3 thepm1x thepm2y thepm3z |
	super initialize.
	rpmp1 := StMConstantParameter name: #rpmp1.
	rpmp2 := StMConstantParameter name: #rpmp2.
	rpmp3 := StMConstantParameter name: #rpmp3.
	rpmp := SymFullColumn with: rpmp1 with: rpmp2 with: rpmp3.
	thepm1x := StMConstantParameter name: #thepm1x.
	thepm2y := StMConstantParameter name: #thepm2y.
	thepm3z := StMConstantParameter name: #thepm3z.
	thepm := SymEulerAngles with: thepm1x with: thepm2y with: thepm3z
]

{ #category : 'accessing' }
SymMarkerFrame >> ppAOmpEpE [

	| aApm ppAOmpEpE ppAOppEpE ppAOppEpEi ppAOppEpEij |
	aApm := self aApm.
	ppAOmpEpE := SymFullMatrix new: 4 by: 4.
	ppAOppEpE := sup ppAOppEpE.
	1 to: 4 do: [ :i |
		ppAOppEpEi := ppAOppEpE at: i.
		1 to: 4 do: [ :j |
			ppAOppEpEij := ppAOppEpEi at: j.
			ppAOmpEpE at: i and: j put: (ppAOppEpEij timesFullMatrix: aApm) ] ].
	^ ppAOmpEpE
]

{ #category : 'accessing' }
SymMarkerFrame >> pprOmOpEpE [

	| rpmp pprOmOpEpE ppAOppEpE ppAOppEpEi ppAOppEpEij |
	rpmp := self rpmp.
	pprOmOpEpE := SymFullMatrix new: 4 by: 4.
	ppAOppEpE := sup ppAOppEpE.
	1 to: 4 do: [ :i |
		ppAOppEpEi := ppAOppEpE at: i.
		1 to: 4 do: [ :j |
			ppAOppEpEij := ppAOppEpEi at: j.
			pprOmOpEpE at: i and: j put: (ppAOppEpEij timesFullColumn: rpmp) ] ].
	^ pprOmOpEpE
]

{ #category : 'accessing' }
SymMarkerFrame >> prOmOpE [

	| prOmOpE pAOppE pAOppEi |
	prOmOpE := SymFullMatrix new: 3 by: 4.
	pAOppE := sup pAOppE.
	pAOppE ifNil: [
		prOmOpE := nil.
		^ prOmOpE ].
	1 to: 4 do: [ :i |
		pAOppEi := pAOppE at: i.
		prOmOpE at: 1 and: i putFullColumn: (pAOppEi timesFullColumn: rpmp) ].
	^ prOmOpE
]

{ #category : 'accessing' }
SymMarkerFrame >> rOmO [

	^ rOmO
]

{ #category : 'removing' }
SymMarkerFrame >> removeEndFrm: endFrm [

	subs remove: endFrm ifAbsent: nil
]

{ #category : 'accessing' }
SymMarkerFrame >> rpmp [

	^ rpmp
]

{ #category : 'accessing' }
SymMarkerFrame >> rpmp: col [

	1 to: 3 do: [ :i | (rpmp at: i) value: (col at: i) asSymbolic ].
	rpmp := rpmp simplified.
	rFfF := rpmp
]

{ #category : 'accessing' }
SymMarkerFrame >> setVelICValues: col [

	subs do: [ :eFrm | eFrm setVelICValues: col ]
]

{ #category : 'accessing' }
SymMarkerFrame >> setqsu: col [

	subs do: [ :eFrm | eFrm setqsu: col ]
]

{ #category : 'accessing' }
SymMarkerFrame >> setqsudotlam: col [

	subs do: [ :eFrm | eFrm setqsudotlam: col ]
]

{ #category : 'accessing' }
SymMarkerFrame >> setqsulam: col [

	subs do: [ :eFrm | eFrm setqsulam: col ]
]

{ #category : 'accessing' }
SymMarkerFrame >> thepm [

	^ thepm
]

{ #category : 'accessing' }
SymMarkerFrame >> thepm: bryantAngles [

	1 to: 3 do: [ :i | (thepm at: i) value: (bryantAngles at: i) ].
	thepm := thepm simplified.
	aApm := thepm aA.
	aAFf := aApm
]
