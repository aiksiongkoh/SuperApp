"
Abstract class for coordinate frame

    Instance Variables
	sup: 		<StCoordinateFrame> Base frame of self
	subs:		<OrderedCollection> Collection of subframes
	aAFf:		<FullMatrix> Rotation matrix such that col(xyz)F = aAFf * col(xyz)f
	aAOf:		<FullMatrix> Rotation matrix such that col(xyz)O = aAOf * col(xyz)f
	body:		<Object> Any body or object attached to the frame
	rFfF:		<FullColumn> Displacement vector r from F to f in F components
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
		'aAFf',
		'rOfO',
		'aAOf',
		'vOfO',
		'omeOfO'
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

	^ self aAOF timesFullMatrix: aAFf
]

{ #category : 'accessing' }
SymCoordinateFrame >> body: anASMTAssembly [ 
	body := anASMTAssembly
]

{ #category : 'initialization' }
SymCoordinateFrame >> initialize [

	subs := OrderedCollection new
]

{ #category : 'accessing' }
SymCoordinateFrame >> omeOfO [

	^ omeOfO
]

{ #category : 'accessing' }
SymCoordinateFrame >> omeOfO: fullCol [

	omeOfO := fullCol
]

{ #category : 'accessing' }
SymCoordinateFrame >> rFfF [

	^ rFfF
]

{ #category : 'accessing' }
SymCoordinateFrame >> rFfF: anObject [

	rFfF := anObject
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

	^ self rOFO + (self aAOF timesFullColumn: rFfF)
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

	^ vOfO
]

{ #category : 'accessing' }
SymCoordinateFrame >> vOfO: fullCol [

	vOfO := fullCol
]
