Class {
	#name : 'ASMTRefContainer',
	#superclass : 'ASMTMovingItem',
	#instVars : [
		'refs',
		'dataSeries'
	],
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'adding' }
ASMTRefContainer >> addRefPoint: refPoint [

	refs add: refPoint.
	refPoint sup: self
]

{ #category : 'DYN' }
ASMTRefContainer >> createMbD [
	"MbDMarkers are created on demand by joints, forces, etc."

	| units partFrm |
	dataSeries := OrderedCollection new.
	units := self units.
	partFrm := self mbdClass new.
	self mbdObject: partFrm.
	partFrm name: self fullName.
	partFrm m: self mass / units mass.
	partFrm aJ: self aJpp / units aJ.
	partFrm qX: self rOcmO / units length.
	partFrm qE: self qEp.
	partFrm qXdot: self vOcmO / units velocity.
	partFrm omeOpO: self omeOpO / units omega.
	partFrm qXddot: (StMFullColumn zero: 3).
	partFrm qEddot: (StMFullColumn zero: 4).
	self addPartFrm: partFrm
]

{ #category : 'initialization' }
ASMTRefContainer >> initialize [

	super initialize.
	refs := OrderedCollection new.
	dataSeries := OrderedCollection new
]

{ #category : 'parsing' }
ASMTRefContainer >> parseRefCurves: lines [

	[ lines removeFirst trim = 'RefCurves' ] assert.
	[ lines first trim = 'RefCurve' ] whileTrue: [
		self parseRefCurve: lines ]
]

{ #category : 'parsing' }
ASMTRefContainer >> parseRefPoint: lines [

	| refPoint |
	refPoint := ASMTPointRefFrame new.
	self addRefPoint: refPoint.
	refPoint parseASMT: lines
]

{ #category : 'parsing' }
ASMTRefContainer >> parseRefPoints: lines [

	[ lines removeFirst trim = 'RefPoints' ] assert.
	[ lines first trim = 'RefPoint' ] whileTrue: [
		self parseRefPoint: lines ]
]

{ #category : 'parsing' }
ASMTRefContainer >> parseRefSurfaces: lines [

	[ lines removeFirst trim = 'RefSurfaces' ] assert.
	[ lines first trim = 'RefSurface' ] whileTrue: [
		self parseRefSurface: lines ]
]
