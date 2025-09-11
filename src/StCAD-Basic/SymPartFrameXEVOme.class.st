"
The states are generalized coordinates and generalized velocities
qX = rapa
qE = Euler Parameters ap
vX = vapa = qXdot
vOmega = omeapa(t) or omeapp(t)
"
Class {
	#name : 'SymPartFrameXEVOme',
	#superclass : 'SymPartFrameXEV',
	#instVars : [
		'vOmega',
		'vOmegadot',
		'ivOmega',
		'wvOmega',
		'pEdot123',
		'pTpE123',
		'ppE123pvOmega'
	],
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'as yet unclassified' }
SymPartFrameXEVOme >> assignVdotICEqnNum: i [

	ivX := i.
	ivOmega := i + 3.
	^ i + 6
]

{ #category : 'ops' }
SymPartFrameXEVOme >> assignVelICEqnNum: eqnNo [

	self ivX: eqnNo.
	self ivOmega: eqnNo + 3.
	^ eqnNo + 6
]

{ #category : 'calc' }
SymPartFrameXEVOme >> calcpTpE [

	super calcpTpE.
	pTpE123 := pTpE copyFrom: 1 to: 3
]

{ #category : 'as yet unclassified' }
SymPartFrameXEVOme >> fillAccICVdotIterError: col [

	col at: ivX minusFullColumn: pXdot asNumber.
	col at: ivOmega minusFullColumn: pEdot123 asNumber.
	col at: ivOmega plusFullColumn: pTpE123 asNumber.

	subs do: [ :mkr | mkr fillAccICVdotIterError: col ].
	aGeu fillAccICVdotIterError: col.
	aGabs do: [ :con | con fillAccICVdotIterError: col ]
]

{ #category : 'velIC' }
SymPartFrameXEVOme >> fillVelICError: col [

	col at: ivX putFullColumn: (wvX timesFullColumn: vX asNumber).
	col at: ivOmega putFullColumn: (wvOmega timesFullColumn: vOmega asNumber).
	super fillVelICError: col
]

{ #category : 'velIC' }
SymPartFrameXEVOme >> fillVelICJacob: mat [

	mat at: ivX and: ivX plusDiagonalMatrix: wvX.
	mat at: ivOmega and: ivOmega plusDiagonalMatrix: wvOmega.
	super fillVelICJacob: mat
]

{ #category : 'as yet unclassified' }
SymPartFrameXEVOme >> fillvdotsuddotlam: col [

	col at: ivX putFullColumn: vXdot.
	col at: ivOmega putFullColumn: vOmegadot.
	subs do: [ :mkr | mkr fillvdotsuddotlam: col ].
	aGeu fillvdotsuddotlam: col.
	aGabs do: [ :con | con fillvdotsuddotlam: col ]
]

{ #category : 'accessing' }
SymPartFrameXEVOme >> initVariables [

	| t block selffullName |
	t := self time.
	qX do: [ :qi | qi x: t ].
	qE do: [ :qi | qi x: t ].
	vX do: [ :vi | vi x: t ].
	vOmega do: [ :vi | vi x: t ].
	selffullName := self fullName.
	block := [ :var |
		         | fullName |
		         fullName := String new writeStream
			                     nextPutAll: selffullName;
			                     nextPut: $/;
			                     nextPutAll: var name;
			                     contents.
		         var name: fullName asSymbol ].
	qX do: block.
	qE do: block.
	vX do: block.
	vOmega do: block
]

{ #category : 'accessing' }
SymPartFrameXEVOme >> ivE [

	^ ivOmega
]

{ #category : 'accessing' }
SymPartFrameXEVOme >> ivOmega [

	^ ivOmega
]

{ #category : 'accessing' }
SymPartFrameXEVOme >> ivOmega: eqnNo [

	ivOmega := eqnNo
]

{ #category : 'velIC' }
SymPartFrameXEVOme >> preVelIC [
	"
	wvX and wvOmega are set to their respective inertias.
	When the inertias are zero, they are set to a small number for positive definiteness.
	They are not set to zero because inertialess part may be underconstrained.
	"

	| mMax aJiMax maxInertia minw maxw aJi |
	mMax := self maximumMass.
	aJiMax := self maximumMomentOfInertia.
	maxInertia := mMax max: aJiMax.
	maxInertia = 0 ifTrue: [ maxInertia := 1.0 ].
	minw := 1.0d-12 * maxInertia.
	maxw := maxInertia.
	wvX := StMDiagonalMatrix new: 3.
	wvOmega := StMDiagonalMatrix new: 3.
	1 to: 3 do: [ :i |
		wvX at: i put: maxw * mass / maxInertia + minw.
		aJi := aJpp at: i.
		wvOmega at: i put: maxw * aJi / maxInertia + minw ]
]

{ #category : 'initialization' }
SymPartFrameXEVOme >> setVelICValues: col [

	vX equalFullColumn: col at: ivX.
	vOmega equalFullColumn: col at: ivOmega.
	subs do: [ :mkr | mkr setVelICValues: col ].
	aGabs do: [ :con | con setVelICValues: col ]
]

{ #category : 'accessing' }
SymPartFrameXEVOme >> vOmega [

	^ vOmega
]

{ #category : 'accessing' }
SymPartFrameXEVOme >> vOmega: col [

	1 to: 3 do: [ :i | (vOmega at: i) rhs: (col at: i) ]
]

{ #category : 'accessing' }
SymPartFrameXEVOme >> vOmegadot [

	^ vOmegadot
]

{ #category : 'accessing' }
SymPartFrameXEVOme >> vOmegadot: col [

	vOmegadot := col asSymbolic
]

{ #category : 'as yet unclassified' }
SymPartFrameXEVOme >> vposdot [

	^ vXdot
]

{ #category : 'as yet unclassified' }
SymPartFrameXEVOme >> vrot [

	^ vOmega
]

{ #category : 'as yet unclassified' }
SymPartFrameXEVOme >> vrotdot [

	^ vOmegadot
]
