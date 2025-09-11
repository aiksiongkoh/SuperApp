"
The states are generalized coordinates and generalized velocities
qX = rapa
qE = Euler Parameters ap
vX = vapa = qXdot
see subclass
"
Class {
	#name : 'SymPartFrameXEV',
	#superclass : 'SymPartFrame',
	#instVars : [
		'vX',
		'vXdot',
		'ppXpvX',
		'ivX',
		'wvX',
		'mX'
	],
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'calc' }
SymPartFrameXEV >> initialize [

	| vX1 vX2 vX3 |
	super initialize.
	vX1 := UnknownDependentVariable name: #vX1.
	vX2 := UnknownDependentVariable name: #vX2.
	vX3 := UnknownDependentVariable name: #vX3.
	vX := SymFullColumn with: vX1 with: vX2 with: vX3.
	vXdot := SymFullColumn with: 0.0 with: 0.0 with: 0.0
]

{ #category : 'accessing' }
SymPartFrameXEV >> ivX [

	^ ivX
]

{ #category : 'accessing' }
SymPartFrameXEV >> ivX: eqnNo [

	ivX := eqnNo
]

{ #category : 'accessing' }
SymPartFrameXEV >> vX [

	^ vX
]

{ #category : 'accessing' }
SymPartFrameXEV >> vX: col [

	1 to: 3 do: [ :i | (vX at: i) rhs: (col at: i) ]
]

{ #category : 'accessing' }
SymPartFrameXEV >> vXdot [

	^ vXdot
]

{ #category : 'accessing' }
SymPartFrameXEV >> vXdot: col [

	vXdot := col asSymbolic
]

{ #category : 'accessing' }
SymPartFrameXEV >> vapa [

	^ vX
]

{ #category : 'as yet unclassified' }
SymPartFrameXEV >> vdotOpO [

	| vdotOpO |
	vdotOpO := self vdotOaO + (self aAddotOa timesFullColumn: self rapa)
	           + (self aAdotOa timesFullColumn: self vapa)
	           + (self aAdotOa timesFullColumn: self vapa)
	           + (self aAOa timesFullColumn: self vdotapa).
	^ vdotOpO
]

{ #category : 'accessing' }
SymPartFrameXEV >> vdotapa [

	^ vXdot
]

{ #category : 'as yet unclassified' }
SymPartFrameXEV >> vpos [

	^ vX
]
