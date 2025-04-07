"
Instance Variables
	s:		<OrderedCollection> collection of one or two geometric parameters for curve or surface respectively

"
Class {
	#name : 'SymEndFrames',
	#superclass : 'SymEndFrame',
	#instVars : [
		's',
		'aAmes',
		'is',
		'sdot',
		'sddot'
	],
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'calc' }
SymEndFrames >> calcAll [

	super calcAll.
	self halt
]

{ #category : 'accessing' }
SymEndFrames >> fillContactEndFrames: collection [

	collection add: self
]

{ #category : 'accessing' }
SymEndFrames >> fillqsu: col [

	col at: is putFullColumn: s asValue
]

{ #category : 'accessing' }
SymEndFrames >> fillqsuWeights: col [
	"Add a small weight just to prevent singularity from unconstrained s."

	| iOffset |
	iOffset := is - 1.
	1 to: s size do: [ :ii | col at: iOffset + ii put: 1.0d-6 ]
]

{ #category : 'accessing' }
SymEndFrames >> fillqsuddotlam: col [

	col at: is putFullColumn: sddot
]

{ #category : 'accessing' }
SymEndFrames >> fillqsudot: col [

	col at: is putFullColumn: sdot asValue
]

{ #category : 'accessing' }
SymEndFrames >> fillqsudotWeights: col [

	| iOffset |
	iOffset := is - 1.
	1 to: s size do: [ :ii | col at: iOffset + ii put: 0.0 ]
]

{ #category : 'accessing' }
SymEndFrames >> fillqsulam: col [

	col at: is putFullColumn: s asValue
]

{ #category : 'accessing' }
SymEndFrames >> initVariables [

	| t |
	t := self time.
	s do: [ :si | si x: t ]
]

{ #category : 'initialization' }
SymEndFrames >> initialize [

	| rmems1 rmems2 rmems3 themes1x themes2y themes3z |
	"Known function of s to define geometry""Prescribed function of s"
	super initialize.
	rmems1 := StMVariableParameter name: #rmems1.
	rmems2 := StMVariableParameter name: #rmems2.
	rmems3 := StMVariableParameter name: #rmems3.
	rmem := SymFullColumn with: rmems1 with: rmems2 with: rmems3.
	rmem do: [ :r | r x: s ].
	themes1x := StMConstantParameter name: #themes1x.
	themes2y := StMConstantParameter name: #themes2y.
	themes3z := StMConstantParameter name: #themes3z.
	theme := SymEulerAngles with: themes1x with: themes2y with: themes3z.
	aAme := theme aA
]

{ #category : 'initialization' }
SymEndFrames >> setVelICValues: col [

	self halt
]

{ #category : 'accessing' }
SymEndFrames >> setqsu: col [

	s equalFullColumn: col at: is
]

{ #category : 'accessing' }
SymEndFrames >> setqsudotlam: col [

	sdot equalFullColumn: col at: is
]

{ #category : 'accessing' }
SymEndFrames >> setqsulam: col [

	s equalFullColumn: col at: is
]

{ #category : 'accessing' }
SymEndFrames >> sup: markerFrm [

	| t |
	super sup: markerFrm.
	t := self time.
	s do: [ :si | si x: t ]
]
