Class {
	#name : 'SymMarkerFrame',
	#superclass : 'SymDependentFrame',
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'accessing' }
SymMarkerFrame >> aAOm [

	^ aAOf
]

{ #category : 'accessing' }
SymMarkerFrame >> aApm [

	^ aAFf
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
SymMarkerFrame >> endFrms [

	^ subs
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

	| block selffullName |
	selffullName := self fullName.
	block := [ :var |
		         | fullName |
		         fullName := String new writeStream
			                     nextPutAll: selffullName;
			                     nextPut: $/;
			                     nextPutAll: var name;
			                     contents.
		         var name: fullName asSymbol ].
	rFfF do: block.
	theFf do: block
]

{ #category : 'initialization' }
SymMarkerFrame >> initialize [

	| rpmp1 rpmp2 rpmp3 rpmp thepm1x thepm2y thepm3z thepm aApm |
	super initialize.
	rpmp1 := StMConstantParameter name: #rpmp1.
	rpmp2 := StMConstantParameter name: #rpmp2.
	rpmp3 := StMConstantParameter name: #rpmp3.
	rpmp := SymFullColumn with: rpmp1 with: rpmp2 with: rpmp3.
	rFfF := rpmp.
	thepm1x := StMConstantParameter name: #thepm1x.
	thepm2y := StMConstantParameter name: #thepm2y.
	thepm3z := StMConstantParameter name: #thepm3z.
	thepm := SymEulerAngles with: thepm1x with: thepm2y with: thepm3z.
	theFf := thepm.
	aApm := thepm aA.
	aAFf := aApm
]

{ #category : 'initialization' }
SymMarkerFrame >> initializeGlobally [

	subs do: [ :eFrm | eFrm initializeGlobally ]
]

{ #category : 'accessing' }
SymMarkerFrame >> omeOmO [

	^ self omeOfO
]

{ #category : 'input-output' }
SymMarkerFrame >> postInput [

	super postInput.
	subs do: [ :endFrm | endFrm postInput ]
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

	^ prOfOpE
]

{ #category : 'accIC' }
SymMarkerFrame >> preAccIC [

	super preAccIC.
	subs do: [ :endFrm | endFrm preAccIC ]
]

{ #category : 'posIC' }
SymMarkerFrame >> prePosIC [

	super prePosIC.
	subs do: [ :endFrm | endFrm prePosIC ]
]

{ #category : 'accessing' }
SymMarkerFrame >> rOmO [

	^ rOfO
]

{ #category : 'removing' }
SymMarkerFrame >> removeEndFrm: endFrm [

	subs remove: endFrm ifAbsent: nil
]

{ #category : 'accessing' }
SymMarkerFrame >> rpmp [

	^ rFfF
]

{ #category : 'accessing' }
SymMarkerFrame >> rpmp: col [

	self rFfF: col
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

	^ theFf
]

{ #category : 'accessing' }
SymMarkerFrame >> thepm: bryantAngles [

	| aApm |
	1 to: 3 do: [ :i | (theFf at: i) rhs: (bryantAngles at: i) ].
	theFf := theFf simplified.
	aApm := theFf aA.
	aAFf := aApm
]
