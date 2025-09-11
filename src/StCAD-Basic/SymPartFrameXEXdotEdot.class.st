"
The states are generalized coordinates and generalized velocities
qX = rapa
qE = Euler Parameters ap
vX = qXdot
vE = qEdot
"
Class {
	#name : 'SymPartFrameXEXdotEdot',
	#superclass : 'SymPartFrame',
	#instVars : [
		'qXdot',
		'qEdot',
		'qXddot',
		'qEddot',
		'wqXdot',
		'wqEdot'
	],
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'accIC' }
SymPartFrameXEXdotEdot >> fillAccICIterError: col [

	| mX mEdot mE |
	col at: iqX minusFullColumn: (mX timesFullColumn: qXddot).
	col at: iqE minusFullColumn: (mEdot timesFullColumn: qEdot).
	col at: iqE minusFullColumn: (mE timesFullColumn: qEddot).
	col at: iqE plusFullColumn: pTpE.

	subs do: [ :mkr | mkr fillAccICIterError: col ].
	aGeu fillAccICIterError: col.
	aGabs do: [ :con | con fillAccICIterError: col ]
]

{ #category : 'velIC' }
SymPartFrameXEXdotEdot >> fillVelICError: col [

	col at: iqX putFullColumn: (wqXdot timesFullColumn: qXdot asNumber).
	col at: iqE putFullColumn: (wqEdot timesFullColumn: qEdot asNumber).
	super fillVelICError: col
]

{ #category : 'velIC' }
SymPartFrameXEXdotEdot >> fillVelICJacob: mat [

	mat at: iqX and: iqX plusDiagonalMatrix: wqXdot.
	mat at: iqE and: iqE plusDiagonalMatrix: wqEdot.
	super fillVelICJacob: mat
]

{ #category : 'accessing' }
SymPartFrameXEXdotEdot >> fillqsuddotlam: col [

	col at: iqX putFullColumn: qXddot.
	col at: iqE putFullColumn: qEddot.
	subs do: [ :mkr | mkr fillqsuddotlam: col ].
	aGeu fillqsuddotlam: col.
	aGabs do: [ :con | con fillqsuddotlam: col ]
]

{ #category : 'accessing' }
SymPartFrameXEXdotEdot >> fillqsudot: col [

	col at: iqX putFullColumn: qXdot asNumber.
	col at: iqE putFullColumn: qEdot asFullColumn asNumber.
	subs do: [ :mkr | mkr fillqsudot: col ]
]

{ #category : 'velIC' }
SymPartFrameXEXdotEdot >> preVelIC [
	"
	wqXdot and wqEdot are set to their respective inertias.
	When the inertias are zero, they are set to a small number for positive definiteness.
	They are not set to zero because inertialess part may be underconstrained.
	wqEdot(4) = 0.0d is ok because there is always the euler parameter constraint.
	"

	| mMax aJiMax maxInertia minw maxw aJi |
	mMax := self maximumMass.
	aJiMax := self maximumMomentOfInertia.
	maxInertia := mMax max: aJiMax.
	maxInertia = 0 ifTrue: [ maxInertia := 1.0 ].
	minw := 1.0d-12 * maxInertia.
	maxw := maxInertia.
	wqXdot := StMDiagonalMatrix new: 3.
	wqEdot := StMDiagonalMatrix new: 4.
	1 to: 3 do: [ :i |
		wqXdot at: i put: maxw * mass / maxInertia + minw.
		aJi := aJpp at: i.
		wqEdot at: i put: maxw * aJi / maxInertia + minw ].
	wqEdot at: 4 put: minw
]

{ #category : 'accessing' }
SymPartFrameXEXdotEdot >> qEddot [

	^ qEddot
]

{ #category : 'accessing' }
SymPartFrameXEXdotEdot >> qEddot: col [

	qEddot := col
]

{ #category : 'accessing' }
SymPartFrameXEXdotEdot >> qEdot [

	^ qEdot
]

{ #category : 'accessing' }
SymPartFrameXEXdotEdot >> qEdot: col [

	qEdot := col asSymbolic
]

{ #category : 'accessing' }
SymPartFrameXEXdotEdot >> qXddot [

	^ qXddot
]

{ #category : 'accessing' }
SymPartFrameXEXdotEdot >> qXddot: col [

	qXddot := col
]

{ #category : 'accessing' }
SymPartFrameXEXdotEdot >> qXdot [

	^ qXdot
]

{ #category : 'accessing' }
SymPartFrameXEXdotEdot >> qXdot: col [

	qXdot := col asSymbolic
]

{ #category : 'accessing' }
SymPartFrameXEXdotEdot >> setqsudotlam: col [

	qXdot equalFullColumn: col at: iqX.
	qEdot equalFullColumn: col at: iqE.
	subs do: [ :mkr | mkr setqsudotlam: col ].
	aGeu setqsudotlam: col.
	aGabs do: [ :con | con setqsudotlam: col ]
]

{ #category : 'as yet unclassified' }
SymPartFrameXEXdotEdot >> vpos [

	^ qXdot
]

{ #category : 'as yet unclassified' }
SymPartFrameXEXdotEdot >> vposdot [

	^ qXddot
]

{ #category : 'as yet unclassified' }
SymPartFrameXEXdotEdot >> vrot [

	^ qEdot
]

{ #category : 'as yet unclassified' }
SymPartFrameXEXdotEdot >> vrotdot [

	^ qEddot
]
