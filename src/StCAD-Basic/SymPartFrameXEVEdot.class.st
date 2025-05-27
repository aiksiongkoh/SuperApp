"
The states are generalized coordinates and generalized velocities
qX = rapa
qE = Euler Parameters ap
vX = qXdot
vE = qEdot
"
Class {
	#name : 'SymPartFrameXEVEdot',
	#superclass : 'SymPartFrameXEV',
	#instVars : [
		'vE',
		'vEdot',
		'ivE',
		'wqXdot',
		'wqEdot'
	],
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'velIC' }
SymPartFrameXEVEdot >> fillVelICError: col [

	col at: ivX putFullColumn: (wqXdot timesFullColumn: qXdot asNumber).
	col at: ivE putFullColumn: (wqEdot timesFullColumn: qEdot asNumber).
	super fillVelICError: col
]

{ #category : 'velIC' }
SymPartFrameXEVEdot >> fillVelICJacob: mat [

	mat at: ivX and: ivX plusDiagonalMatrix: wqXdot.
	mat at: ivE and: ivE plusDiagonalMatrix: wqEdot.
	super fillVelICJacob: mat
]

{ #category : 'accessing' }
SymPartFrameXEVEdot >> ivE [

	^ ivE
]

{ #category : 'velIC' }
SymPartFrameXEVEdot >> preVelIC [
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
