"
themet is EulerAngles for Marker to EndFrame as functions of time.
Rotation order of axes is stored in RotOrder in EulerAngles.
"
Class {
	#name : 'SymEndFramet',
	#superclass : 'SymEndFrame',
	#instVars : [
		'prmempt',
		'pprmemptpt',
		'pAmept',
		'ppAmeptpt',
		'pthemept'
	],
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'calc' }
SymEndFramet >> calcPostDynCorrectorIteration [


]

{ #category : 'calc' }
SymEndFramet >> calcomeOeO [

	^ sup omeOmO + (sup aAOm timesFullColumn: self omemem)
]

{ #category : 'calc' }
SymEndFramet >> evalAme [
	"Do nothing for Symbolic item"

	
]

{ #category : 'calc' }
SymEndFramet >> evalrmem [
	"Do nothing for Symbolic item"

	
]

{ #category : 'accessing' }
SymEndFramet >> initVariables [

	| t |
	super initVariables.
	t := self time.
	prmempt := rmem differentiateWRT: t.
	pthemept := theme differentiateWRT: t
]

{ #category : 'initialization' }
SymEndFramet >> initialize [

	| rmemt1 rmemt2 rmemt3 themet1x themet2y themet3z |
	super initialize.
	rmemt1 := StMVariableParameter name: #rmemt1.
	rmemt2 := StMVariableParameter name: #rmemt2.
	rmemt3 := StMVariableParameter name: #rmemt3.
	rmem := SymFullColumn with: rmemt1 with: rmemt2 with: rmemt3.
	themet1x := StMVariableParameter name: #themet1x.
	themet2y := StMVariableParameter name: #themet2y.
	themet3z := StMVariableParameter name: #themet3z.
	theme := SymEulerAngles with: themet1x with: themet2y with: themet3z.
	aAme := theme aA
]

{ #category : 'accessing' }
SymEndFramet >> omemem [

	^ pthemept omeF
]

{ #category : 'accessing' }
SymEndFramet >> phiThePsiBlks: blks [

	1 to: 3 do: [ :i | (theme at: i) rhs: (blks at: i) ]
]

{ #category : 'accessing' }
SymEndFramet >> pthemept [

	^ pthemept
]

{ #category : 'accessing' }
SymEndFramet >> rmemBlks: blks [

	1 to: 3 do: [ :i | (rmem at: i) rhs: (blks at: i) ]
]

{ #category : 'accessing' }
SymEndFramet >> sup: markerFrm [

	| t |
	super sup: markerFrm.
	t := self time.
	rFfF do: [ :r | r x: t ].
	themet do: [ :the | the x: t ]
]

{ #category : 'accessing' }
SymEndFramet >> theta3z: sym [

	(theme at: 3) rhs: sym
]
