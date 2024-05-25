"
qE:			<EulerParameters>	State variable. EulerParameters from a to p
	qX:			<FullColumn>			State variable. Displacements rapa(t)
	vOmega:	<FullColumn>			State variable. Angular velocities ome_apa(t)
	vX:			<FullColumn>			State variable. Velocities vapa(t)

"
Class {
	#name : 'SymPartFrame',
	#superclass : 'SymCartesianFrame',
	#instVars : [
		'qX',
		'qE',
		'vX',
		'vOmega',
		'qXdot',
		'qEdot',
		'vXdot',
		'vOmegadot',
		'principalMassFrm',
		'aGeu',
		'aGabs'
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

	^ aAFf
]

{ #category : 'accessing' }
SymPartFrame >> aJ: diagMat [

	principalMassFrm aJpp: diagMat
]

{ #category : 'adding' }
SymPartFrame >> addMarkerF: aStMarkerFrame [

	subs add: aStMarkerFrame.
	aStMarkerFrame sup: self
]

{ #category : 'converting' }
SymPartFrame >> asFixed [

	| con |
	1 to: 6 do: [ :i |
		con := SymAbsConstraint new
			       axis: i;
			       owner: self.
		aGabs add: con ]
]

{ #category : 'calc' }
SymPartFrame >> calcAll [

	rOfO := self calcrOpO.
	aAOf := self calcaAOp.
	subs do: [ :sub | sub calcAll ]
]

{ #category : 'calc' }
SymPartFrame >> calcaAOp [

	^ sup aAOa timesFullMatrix: self aAap
]

{ #category : 'calc' }
SymPartFrame >> calcrOpO [

	^ sup rOaO + (sup aAOa timesFullColumn: self rapa)
]

{ #category : 'initialization' }
SymPartFrame >> initialize [

	| qX1 qX2 qX3 rapa1 rapa2 rapa3 rapa qE1 qE2 qE3 qE4 aAap vX1 vX2 vX3 vOmega1 vOmega2 vOmega3 |
	super initialize.
	aGeu := SymEulerConstraint new.
	aGeu owner: self.
	aGabs := OrderedCollection new.
	principalMassFrm := SymPrincipalMassFrame new.
	qX1 := StMDependentVariable name: #qX1.
	qX2 := StMDependentVariable name: #qX2.
	qX3 := StMDependentVariable name: #qX3.
	qX := StMFullColumn with: qX1 with: qX2 with: qX3.
	rapa1 := qX1.
	rapa2 := qX2.
	rapa3 := qX3.
	rapa := StMFullColumn with: rapa1 with: rapa2 with: rapa3.
	rFfF := rapa simplified.
	qE1 := StMDependentVariable name: #qE1.
	qE2 := StMDependentVariable name: #qE2.
	qE3 := StMDependentVariable name: #qE3.
	qE4 := StMDependentVariable name: #qE4.
	qE := SymEulerParameters
		      with: qE1
		      with: qE2
		      with: qE3
		      with: qE4.
	aAap := qE
		        calc;
		        aA.
	aAFf := aAap simplified.
	vX1 := StMDependentVariable name: #vX1.
	vX2 := StMDependentVariable name: #vX2.
	vX3 := StMDependentVariable name: #vX3.
	vX := StMFullColumn with: vX1 with: vX2 with: vX3.
	vOmega1 := StMDependentVariable name: #vOmega1.
	vOmega2 := StMDependentVariable name: #vOmega2.
	vOmega3 := StMDependentVariable name: #vOmega3.
	vOmega := StMFullColumn with: vOmega1 with: vOmega2 with: vOmega3
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
SymPartFrame >> m: double [

	principalMassFrm mass: double
]

{ #category : 'accessing' }
SymPartFrame >> omeOpO: aCollection [ 
	self shouldBeImplemented.
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
SymPartFrame >> qXdot [

	^ qXdot
]

{ #category : 'accessing' }
SymPartFrame >> qXdot: col [

	qXdot := col asSymbolic
]

{ #category : 'accessing' }
SymPartFrame >> rOpO [

	^ rOfO
]

{ #category : 'accessing' }
SymPartFrame >> rapa [

	^ rFfF
]

{ #category : 'accessing' }
SymPartFrame >> sup: assemblyFrm [

	| t |
	super sup: assemblyFrm.
	t := self time.
	qX do: [ :qi | qi x: t ].
	qE do: [ :qi | qi x: t ].
	vX do: [ :vi | vi x: t ].
	vOmega do: [ :vi | vi x: t ]
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
SymPartFrame >> vOmegadot: col [

	vOmegadot := col asSymbolic
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

{ #category : 'accessing' }
SymPartFrame >> vXdot: col [

	vXdot := col asSymbolic
]
