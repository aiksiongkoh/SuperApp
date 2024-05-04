"
qE:			<EulerParameters>	State variable. EulerParameters from a to p
	qX:			<FullColumn>			State variable. Displacements rapa(t)
	vOmega:	<FullColumn>			State variable. Angular velocities ome_apa(t)
	vX:			<FullColumn>			State variable. Velocities vapa(t)

"
Class {
	#name : #SymPartFrame,
	#superclass : #SymCartesianFrame,
	#instVars : [
		'qX',
		'qE',
		'vX',
		'vOmega',
		'qXdot',
		'qEdot',
		'vXdot',
		'vOmegadot'
	],
	#category : #'StCAD-Basic'
}

{ #category : #accessing }
SymPartFrame >> aAOp [

	^ aAOf
]

{ #category : #accessing }
SymPartFrame >> aAap [

	^ aAFf
]

{ #category : #adding }
SymPartFrame >> addMarkerF: aStMarkerFrame [

	subs add: aStMarkerFrame.
	aStMarkerFrame sup: self
]

{ #category : #calc }
SymPartFrame >> calcAll [

	rOfO := self calcrOpO.
	aAOf := self calcaAOp.
	subs do: [ :sub | sub calcAll ]
]

{ #category : #calc }
SymPartFrame >> calcaAOp [

	^ sup aAOa timesFullMatrix: self aAap
]

{ #category : #calc }
SymPartFrame >> calcrOpO [

	^ sup rOaO + (sup aAOa timesFullColumn: self rapa)
]

{ #category : #initialization }
SymPartFrame >> initialize [

	| qX1 qX2 qX3 rapa1 rapa2 rapa3 rapa qE1 qE2 qE3 qE4 aAap vX1 vX2 vX3 vOmega1 vOmega2 vOmega3 |
	super initialize.
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

{ #category : #accessing }
SymPartFrame >> rOpO [

	^ rOfO
]

{ #category : #accessing }
SymPartFrame >> rapa [

	^ rFfF
]

{ #category : #accessing }
SymPartFrame >> sup: aStAssemblyFrame [

	| t |
	sup := aStAssemblyFrame.
	t := self time.
	qX do: [ :qi | qi x: t ].
	qE do: [ :qi | qi x: t ].
	vX do: [ :vi | vi x: t ].
	vOmega do: [ :vi | vi x: t ]
]
