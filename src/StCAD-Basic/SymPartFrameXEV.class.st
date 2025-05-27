Class {
	#name : 'SymPartFrameXEV',
	#superclass : 'SymPartFrame',
	#instVars : [
		'vX',
		'vXdot',
		'ivX'
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
	vapa := vX.
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

	1 to: 3 do: [ :i | (vX at: i) value: (col at: i) ]
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
