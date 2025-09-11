"
Abstract class for coordinate frame

    Instance Variables
	sup: 		<StCoordinateFrame> Base frame of self
	subs:		<OrderedCollection> Collection of subframes
	aAFf:		<FullMatrix> Rotation matrix such that col(xyz)F = aAFf * col(xyz)f
	aAOf:		<FullMatrix> Rotation matrix such that col(xyz)O = aAOf * col(xyz)f
	body:		<Object> Any body or object attached to the frame
	rFfF:		<FullColumn> Displacement vector r from F to f in F components
	theFf:   <SymEulerAngles> Euler angles from F to f
	rOfO:		<FullColumn> Displacement vector r from O to f in O components

InertialFrame contains AssemblyFrame contains PartFrame contains MarkerFrame contains EndFrame
 
"
Class {
	#name : 'SymCoordinateFrame',
	#superclass : 'SymItem',
	#instVars : [
		'subs',
		'body',
		'rFfF',
		'theFf',
		'aAFf',
		'rOfO',
		'aAOf',
		'pAOfpt',
		'ppAOfptpt',
		'pprOfOptpt',
		'prOfOpt'
	],
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'accessing' }
SymCoordinateFrame >> aAFf [

	^ aAFf
]

{ #category : 'accessing' }
SymCoordinateFrame >> aAFf: anObject [

	aAFf := anObject
]

{ #category : 'accessing' }
SymCoordinateFrame >> aAOF [

	^ sup aAOf
]

{ #category : 'accessing' }
SymCoordinateFrame >> aAOf [
	"^ self aAOF timesFullMatrix: aAFf"

	^ aAOf
]

{ #category : 'accessing' }
SymCoordinateFrame >> body [

	^ body
]

{ #category : 'accessing' }
SymCoordinateFrame >> body: asmtObj [

	body := asmtObj
]

{ #category : 'initialization' }
SymCoordinateFrame >> initialize [

	subs := OrderedCollection new
]

{ #category : 'accessing' }
SymCoordinateFrame >> omeOfO [

	| omeTilde |
	omeTilde := self omeSkewOfO.
	^ StMFullColumn
		  with: (omeTilde at: 2 and: 3) negated
		  with: (omeTilde at: 1 and: 3)
		  with: (omeTilde at: 1 and: 2) negated
]

{ #category : 'accessing' }
SymCoordinateFrame >> omeOfO: ome [
	"aAdot := omeSkew * aA"

	"omeSkew := aAdot * aA^T"

	| omeSkew row |
	omeSkew := StMFullMatrix new: 3 by: 3.
	row := omeSkew at: 1.
	row
		at: 1 put: 0.0;
		at: 2 put: (ome at: 3) negated;
		at: 3 put: (ome at: 2).
	row := omeSkew at: 2.
	row
		at: 1 put: (ome at: 3);
		at: 2 put: 0.0;
		at: 3 put: (ome at: 1) negated.
	row := omeSkew at: 3.
	row
		at: 1 put: (ome at: 2) negated;
		at: 2 put: (ome at: 1);
		at: 3 put: 0.0.
	pAOfpt := omeSkew timesFullMatrix: aAOf
]

{ #category : 'accessing' }
SymCoordinateFrame >> omeSkewOfO [
	"aAdot := omeTilde * aA"

	"omeTilde := aAdot * aA^T"

	^ pAOfpt timesTransposeFullMatrix: aAOf
]

{ #category : 'accessing' }
SymCoordinateFrame >> omedotOfO [

	| omedotTilde |
	omedotTilde := self omedotSkewOfO.
	^ StMFullColumn
		  with: (omedotTilde at: 2 and: 3) negated
		  with: (omedotTilde at: 1 and: 3)
		  with: (omedotTilde at: 1 and: 2) negated
]

{ #category : 'accessing' }
SymCoordinateFrame >> omedotSkewOfO [
	"aAddot := omedotTilde * aA + omeTilde * aAdot"

	"omedotTilde := (aAddot - omeTilde * aAdot) * aA^T"

	| omeTilde |
	omeTilde := self omeSkewOfO.

	^ ppAOfptpt - (omeTilde timesFullMatrix: pAOfpt)
		  timesTransposeFullMatrix: aAOf
]

{ #category : 'accessing' }
SymCoordinateFrame >> rFfF [

	^ rFfF
]

{ #category : 'accessing' }
SymCoordinateFrame >> rFfF: col [

	1 to: 3 do: [ :i | (rFfF at: i) rhs: (col at: i) asSymbolic ].
	rFfF := rFfF simplified
]

{ #category : 'accessing' }
SymCoordinateFrame >> rFpFfromrOpO: rOpO [

	^ sup rfpffromrOpO: rOpO
]

{ #category : 'accessing' }
SymCoordinateFrame >> rFpFfromrfpf: rfpf [

	^ rFfF + (aAFf timesFullColumn: rfpf)
]

{ #category : 'accessing' }
SymCoordinateFrame >> rOFO [

	^ sup rOfO
]

{ #category : 'accessing' }
SymCoordinateFrame >> rOfO [
	"^ self rOFO + (self aAOF timesFullColumn: rFfF)"

	^ rOfO
]

{ #category : 'accessing' }
SymCoordinateFrame >> rOpOfromrfpf: rfpf [

	^ self rOfO + (self aAOf timesFullColumn: rfpf)
]

{ #category : 'accessing' }
SymCoordinateFrame >> rfpffromrFpF: rFpF [

	^ aAFf transpose timesFullColumn: rFpF - rFfF
]

{ #category : 'accessing' }
SymCoordinateFrame >> rfpffromrOpO: rOpO [

	^ self aAOf transpose timesFullColumn: rOpO - self rOfO
]

{ #category : 'accessing' }
SymCoordinateFrame >> subs [
	^ subs
]

{ #category : 'accessing' }
SymCoordinateFrame >> vOfO [

	^ prOfOpt
]

{ #category : 'accessing' }
SymCoordinateFrame >> vOfO: fullCol [

	prOfOpt := fullCol
]
