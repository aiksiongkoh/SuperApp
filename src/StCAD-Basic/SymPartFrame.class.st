"
1110kine.odt

SymPartFrame is at center of mass and oriented in principal directions.

qE:			<EulerParameters>	State variable. EulerParameters from a to p
qX:			<FullColumn>			State variable. Displacements rapa(t)
vOmega:	<FullColumn>			State variable. Angular velocities ome_apa(t)
vX:			<FullColumn>			State variable. Velocities vapa(t)

"
Class {
	#name : 'SymPartFrame',
	#superclass : 'SymCartesianFrame',
	#instVars : [
		'iqX',
		'iqE',
		'qX',
		'qE',
		'qXdot',
		'qEdot',
		'qXddot',
		'qEddot',
		'aGeu',
		'aGabs',
		'mass',
		'aJpp',
		'density',
		'rOpO',
		'aAOp',
		'vOpO',
		'omeOpO',
		'rapa',
		'aAap',
		'vapa',
		'kineticEnergyT',
		'omeOpp',
		'pTpOmeOpp',
		'ppTpOmeOpppOmeOpp',
		'pX',
		'pXdot',
		'pE',
		'pEdot',
		'ppTpEpEdot'
	],
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'accessing' }
SymPartFrame >> aAOp [

	^ aAOf
]

{ #category : 'accessing' }
SymPartFrame >> aAap [

	^aAap
	
]

{ #category : 'accessing' }
SymPartFrame >> aB [

	^ qE aB
]

{ #category : 'accessing' }
SymPartFrame >> aJ: diagMat [

	aJpp := diagMat
]

{ #category : 'accessing' }
SymPartFrame >> aJpp [

	^ aJpp
]

{ #category : 'accessing' }
SymPartFrame >> aJpp: anObject [

	aJpp := anObject
]

{ #category : 'adding' }
SymPartFrame >> addMarkerF: aStMarkerFrame [

	subs add: aStMarkerFrame.
	aStMarkerFrame sup: self
]

{ #category : 'adding' }
SymPartFrame >> addMarkerFrm: markerFrm [

	subs add: markerFrm.
	markerFrm sup: self
]

{ #category : 'converting' }
SymPartFrame >> asFixed [

	| con |
	1 to: 6 do: [ :i |
		con := SymAbsConstraint new
			       axis: i;
			       sup: self.
		aGabs add: con ]
]

{ #category : 'calc' }
SymPartFrame >> calcKine [

	rOpO := (self rOaO + (self aAOa timesFullColumn: rapa)) simplified.
	aAOp := (self aAOa timesFullMatrix: aAap) simplified.
	rOfO := rOpO.
	aAOf := aAOp
]

{ #category : 'calc' }
SymPartFrame >> calcPostDynCorrectorIteration [


]

{ #category : 'calc' }
SymPartFrame >> calcpApE [
	self shouldBeImplemented.
]

{ #category : 'accessing' }
SymPartFrame >> constraintsReport [

	| dummy |
	dummy := aGabs select: [ :con | con isRedundant ].
	aGeu isRedundant ifTrue: [ dummy add: aGeu ].
	dummy size > 0 ifTrue: [
		self
			logString: #'MbD: \%1 %2  has the following constraint(s) removed: '
			withArguments: (Array with: self classString with: name).
		dummy do: [ :con | con logString: #'MbD: \    %1' withArgument: con classString ] ]
]

{ #category : 'accessing' }
SymPartFrame >> density [

	^ density
]

{ #category : 'accessing' }
SymPartFrame >> density: anObject [

	density := anObject
]

{ #category : 'accIC' }
SymPartFrame >> fillAccICIterJacob: mat [

	| mX mE |
	mat at: iqX and: iqX minusDiagonalMatrix: mX.
	mat at: iqE and: iqE minusFullMatrix: mE.
	subs do: [ :mkr | mkr fillAccICIterJacob: mat ].
	aGeu fillAccICIterJacob: mat.
	aGabs do: [ :con | con fillAccICIterJacob: mat ]
]

{ #category : 'accessing' }
SymPartFrame >> fillConstraints: collection [

	aGeu fillConstraints: collection.
	aGabs do: [ :con | con fillConstraints: collection ]
]

{ #category : 'accessing' }
SymPartFrame >> fillContactEndFrames: collection [

	subs do: [ :mFrm | mFrm fillContactEndFrames: collection ]
]

{ #category : 'accessing' }
SymPartFrame >> fillEssenConstraints: collection [

	aGeu fillEssenConstraints: collection.
	aGabs do: [ :con | con fillEssenConstraints: collection ]
]

{ #category : 'accessing' }
SymPartFrame >> fillPartFrames: collection [

	collection add: self
]

{ #category : 'posIC' }
SymPartFrame >> fillPosICError: col [

	subs do: [ :mkr | mkr fillPosICError: col ].
	aGeu fillPosICError: col.
	aGabs do: [ :con | con fillPosICError: col ]
]

{ #category : 'posIC' }
SymPartFrame >> fillPosICJacob: mat [

	subs do: [ :mkr | mkr fillPosICJacob: mat ].
	aGeu fillPosICJacob: mat.
	aGabs do: [ :con | con fillPosICJacob: mat ]
]

{ #category : 'accessing' }
SymPartFrame >> fillRedundantConstraints: collection [

	aGeu fillRedundantConstraints: collection.
	aGabs do: [ :con | con fillRedundantConstraints: collection ]
]

{ #category : 'velIC' }
SymPartFrame >> fillVelICError: col [

	subs do: [ :mkr | mkr fillVelICError: col ].
	aGeu fillVelICError: col.
	aGabs do: [ :con | con fillVelICError: col ]
]

{ #category : 'velIC' }
SymPartFrame >> fillVelICJacob: mat [

	subs do: [ :mkr | mkr fillVelICJacob: mat ].
	aGeu fillVelICJacob: mat.
	aGabs do: [ :con | con fillVelICJacob: mat ]
]

{ #category : 'accessing' }
SymPartFrame >> fillqsu: col [

	col at: iqX putFullColumn: qX asValue.
	col at: iqE putFullColumn: qE asFullColumn asValue.
	subs do: [ :mFrm | mFrm fillqsu: col ]
]

{ #category : 'accessing' }
SymPartFrame >> fillqsuWeights: col [
	"Map wqX and wqE according to inertias. (0 to maximum inertia) map to (minw to maxw)"

	"When the inertias are zero, they are set to a small number for positive definiteness."

	"They are not set to zero because inertialess part may be underconstrained."

	"Avoid having two kinds of singularities to confuse redundant constraint removal."

	"Redundant constraint removal likes equal weights."

	"wqE(4) = 0.0d is ok because there is always the euler parameter constraint."

	| mMax aJiMax minw maxw wqX wqE aJi |
	mMax := sup maximumMass.
	aJiMax := sup maximumMomentOfInertia.
	minw := 1000.0.
	maxw := 1.0d6.
	wqX := StMDiagonalMatrix new: 3.
	wqE := StMDiagonalMatrix new: 4.
	mMax = 0 ifTrue: [ mMax := 1.0 ].
	1 to: 3 do: [ :i | wqX at: i put: maxw * mass / mMax + minw ].
	aJiMax = 0 ifTrue: [ aJiMax := 1.0 ].
	1 to: 3 do: [ :i |
		aJi := aJpp at: i.
		wqE at: i put: maxw * aJi / aJiMax + minw ].
	wqE at: 4 put: minw.
	col at: iqX putDiagonalMatrix: wqX.
	col at: iqE putDiagonalMatrix: wqE.
	subs do: [ :mFrm | mFrm fillqsuWeights: col ]
]

{ #category : 'accessing' }
SymPartFrame >> fillqsuddotlam: col [

	col at: iqX putFullColumn: qXddot.
	col at: iqE putFullColumn: qEddot.
	subs do: [ :mkr | mkr fillqsuddotlam: col ].
	aGeu fillqsuddotlam: col.
	aGabs do: [ :con | con fillqsuddotlam: col ]
]

{ #category : 'accessing' }
SymPartFrame >> fillqsudot: col [

	col at: iqX putFullColumn: qXdot asValue.
	col at: iqE putFullColumn: qEdot asFullColumn asValue.
	subs do: [ :mkr | mkr fillqsudot: col ]
]

{ #category : 'accessing' }
SymPartFrame >> fillqsudotWeights: col [
	"wqXdot and wqEdot are set to their respective inertias."

	"When the inertias are zero, they are set to a small number for positive definiteness."

	"They are not set to zero because inertialess part may be underconstrained."

	"wqEdot(4) = 0.0d is ok because there is always the euler parameter constraint."

	| mMax aJiMax maxInertia minw maxw aJi wqXdot wqEdot |
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
	wqEdot at: 4 put: minw.
	col at: iqX putDiagonalMatrix: wqXdot.
	col at: iqE putDiagonalMatrix: wqEdot.
	subs do: [ :mkr | mkr fillqsudotWeights: col ]
]

{ #category : 'accessing' }
SymPartFrame >> fillqsulam: col [
	"Fill q, s and lam into col."

	col at: iqX putFullColumn: qX asValue.
	col at: iqE putFullColumn: qE asFullColumn asValue.
	subs do: [ :mkr | mkr fillqsulam: col ].
	aGeu fillqsulam: col.
	aGabs do: [ :con | con fillqsulam: col ]
]

{ #category : 'calc' }
SymPartFrame >> initialize [

	| qX1 qX2 qX3 rapa1 rapa2 rapa3 qE1 qE2 qE3 qE4 |
	super initialize.
	qX1 := UnknownDependentVariable name: #qX1.
	qX2 := UnknownDependentVariable name: #qX2.
	qX3 := UnknownDependentVariable name: #qX3.
	qX := SymFullColumn with: qX1 with: qX2 with: qX3.
	rapa1 := qX1.
	rapa2 := qX2.
	rapa3 := qX3.
	rapa := SymFullColumn with: rapa1 with: rapa2 with: rapa3.
	rFfF := rapa.
	qE1 := UnknownDependentVariable name: #qE1.
	qE2 := UnknownDependentVariable name: #qE2.
	qE3 := UnknownDependentVariable name: #qE3.
	qE4 := UnknownDependentVariable name: #qE4.
	qE := SymEulerParameters
		      with: qE1
		      with: qE2
		      with: qE3
		      with: qE4.
	aAap := qE aA.
	aAFf := aAap.
	aGeu := SymEulerConstraint new.
	aGeu sup: self.
	aGabs := OrderedCollection new
]

{ #category : 'initialization' }
SymPartFrame >> initializeLocally [

	| markerFrms |
	markerFrms := subs.
	markerFrms do: [ :mkr | mkr initializeLocally ].
	aGeu initializeLocally.
	aGabs do: [ :con | con initializeLocally ]
]

{ #category : 'accessing' }
SymPartFrame >> iqE [

	^ iqE
]

{ #category : 'accessing' }
SymPartFrame >> iqE: anObject [

	iqE := anObject
]

{ #category : 'accessing' }
SymPartFrame >> iqX [

	^ iqX
]

{ #category : 'accessing' }
SymPartFrame >> iqX: anObject [

	iqX := anObject
]

{ #category : 'testing' }
SymPartFrame >> isPartFrame [

	^ true
]

{ #category : 'accessing' }
SymPartFrame >> m [

	^ mass
]

{ #category : 'accessing' }
SymPartFrame >> m: double [

	mass := double
]

{ #category : 'as yet unclassified' }
SymPartFrame >> markerFrms [

	^ subs
]

{ #category : 'accessing' }
SymPartFrame >> mass [

	^ mass
]

{ #category : 'accessing' }
SymPartFrame >> mass: anObject [

	mass := anObject
]

{ #category : 'accessing' }
SymPartFrame >> omeOpO [

	^ omeOfO
]

{ #category : 'accessing' }
SymPartFrame >> omeOpO: aCollection [ 
	self shouldBeImplemented.
]

{ #category : 'accessing' }
SymPartFrame >> pAOppE [

	^ pAOfpE
]

{ #category : 'accessing' }
SymPartFrame >> pAOppt [

	| time |
	time := self time.
	^ aAOf collect: [ :row | row collect: [ :aij | (aij differentiateWRT: time) simplified ] ]
]

{ #category : 'as yet unclassified' }
SymPartFrame >> ppAOppEpE [
	"aAOa * aAap"

	| aAOa ppAappEpE |
	aAOa := sup aAOf.
	ppAappEpE := qE ppApEpE.
	^ ppAappEpE collect: [ :ppAappEipE |
		  ppAappEipE collect: [ :ppAappEipEj | aAOa timesFullMatrix: ppAappEipEj ] ]
]

{ #category : 'as yet unclassified' }
SymPartFrame >> pprOpOpEpE [
	"rOpO := sup rOaO + (sup aAOa timesFullColumn: self rapa)"

	"pprOpOpEpE := zeros"

	^ [ false ] assert
]

{ #category : 'as yet unclassified' }
SymPartFrame >> pprOpOpXpX [
	"rOpO := sup rOaO + (sup aAOa timesFullColumn: self rapa)"

	"pprOpOpEpE := zeros"

	^ [ false ] assert
]

{ #category : 'accessing' }
SymPartFrame >> pqdotpv [

	self subclassResponsibility
]

{ #category : 'as yet unclassified' }
SymPartFrame >> prOpOpE [
	"rOpO := sup rOaO + (sup aAOa timesFullColumn: self rapa)"

	"prOpOpE := zeros"

	^ [ false ] assert
]

{ #category : 'as yet unclassified' }
SymPartFrame >> prOpOpX [
	"sup rOaO + (sup aAOa timesFullColumn: self rapa)"

	^ sup aAOa
]

{ #category : 'accessing' }
SymPartFrame >> qE [

	^ qE
]

{ #category : 'accessing' }
SymPartFrame >> qE: eulerPara [

	1 to: 4 do: [ :i | (qE at: i) value: (eulerPara at: i) ]
]

{ #category : 'accessing' }
SymPartFrame >> qEddot [

	^ qEddot
]

{ #category : 'accessing' }
SymPartFrame >> qEddot: anObject [

	qEddot := anObject
]

{ #category : 'accessing' }
SymPartFrame >> qEdot [

	^ qEdot
]

{ #category : 'accessing' }
SymPartFrame >> qEdot: col [

	qEdot := col asSymbolic
]

{ #category : 'accessing' }
SymPartFrame >> qX [

	^ qX
]

{ #category : 'accessing' }
SymPartFrame >> qX: col [

	1 to: 3 do: [ :i | (qX at: i) value: (col at: i) ]
]

{ #category : 'accessing' }
SymPartFrame >> qXddot [

	^ qXddot
]

{ #category : 'accessing' }
SymPartFrame >> qXddot: anObject [

	qXddot := anObject
]

{ #category : 'accessing' }
SymPartFrame >> qXdot [

	^ qXdot
]

{ #category : 'accessing' }
SymPartFrame >> qXdot: col [

	qXdot := col asSymbolic
]

{ #category : 'accessing' }
SymPartFrame >> rOpO [
	"sup rOaO + (sup aAOa timesFullColumn: self rapa)"

	^ rOpO
]

{ #category : 'accessing' }
SymPartFrame >> rapa [

	^ rapa
]

{ #category : 'removing' }
SymPartFrame >> removeRedundantConstraints: redundantEqns [

	subs do: [ :mkr | mkr removeRedundantConstraints: redundantEqns ].
	aGeu removeRedundantConstraints: redundantEqns.
	aGabs do: [ :con | con removeRedundantConstraints: redundantEqns ]
]

{ #category : 'accessing' }
SymPartFrame >> setqsu: col [

	qX equalFullColumn: col at: iqX.
	qE equalFullColumn: col at: iqE.
	subs do: [ :mkr | mkr setqsu: col ]
]

{ #category : 'accessing' }
SymPartFrame >> setqsudotlam: col [

	qXdot equalFullColumn: col at: iqX.
	qEdot equalFullColumn: col at: iqE.
	subs do: [ :mkr | mkr setqsudotlam: col ].
	aGeu setqsudotlam: col.
	aGabs do: [ :con | con setqsudotlam: col ]
]

{ #category : 'accessing' }
SymPartFrame >> setqsulam: col [

	qX equalFullColumn: col at: iqX.
	qE equalFullColumn: col at: iqE.
	subs do: [ :mkr | mkr setqsulam: col ].
	aGeu setqsulam: col.
	aGabs do: [ :con | con setqsulam: col ]
]

{ #category : 'initialize-release' }
SymPartFrame >> useEquationNumbers [

	subs do: [ :mFrm | mFrm useEquationNumbers ].
	aGeu useEquationNumbers.
	aGabs do: [ :con | con useEquationNumbers ]
]

{ #category : 'initialize-release' }
SymPartFrame >> useVelICEqnNo [

	subs do: [ :mFrm | mFrm useVelICEqnNo ].
	aGeu useVelICEqnNo.
	aGabs do: [ :con | con useVelICEqnNo ]
]

{ #category : 'accessing' }
SymPartFrame >> vOmega [

	^ vOmega
]

{ #category : 'accessing' }
SymPartFrame >> vOmega: col [

	1 to: 3 do: [ :i | (vOmega at: i) value: (col at: i) ]
]

{ #category : 'accessing' }
SymPartFrame >> vOmegadot [

	^ vOmegadot
]

{ #category : 'accessing' }
SymPartFrame >> vOpO [

	^ vOfO
]

{ #category : 'accessing' }
SymPartFrame >> vX [

	^ vX
]

{ #category : 'accessing' }
SymPartFrame >> vX: col [

	1 to: 3 do: [ :i | (vX at: i) value: (col at: i) ]
]

{ #category : 'accessing' }
SymPartFrame >> vXdot [

	^ vXdot
]
