Class {
	#name : 'ASMTPrincipalMassMarker',
	#superclass : 'ASMTSpatialItem',
	#instVars : [
		'aJpp',
		'mass',
		'density'
	],
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'accessing' }
ASMTPrincipalMassMarker >> aJpp [

	^ aJpp
]

{ #category : 'accessing' }
ASMTPrincipalMassMarker >> aJpp: anObject [

	aJpp := anObject
]

{ #category : 'accessing' }
ASMTPrincipalMassMarker >> density [

	^ density
]

{ #category : 'accessing' }
ASMTPrincipalMassMarker >> density: anObject [

	density := anObject
]

{ #category : 'accessing' }
ASMTPrincipalMassMarker >> mass [

	^ mass
]

{ #category : 'accessing' }
ASMTPrincipalMassMarker >> mass: anObject [

	mass := anObject
]

{ #category : 'parsing' }
ASMTPrincipalMassMarker >> parseASMT: lines [

	[ lines removeFirst trim = 'PrincipalMassMarker' ] assert.
	self parseName: lines.
	self parsePosition3D: lines.
	self parseRotationMatrix: lines.
	self parseMass: lines.
	self parseMomentOfInertias: lines.
	self parseDensity: lines
]

{ #category : 'parsing' }
ASMTPrincipalMassMarker >> parseDensity: lines [

	[ lines removeFirst trim = 'Density' ] assert.
	density := self readDoubleOffTop: lines
]

{ #category : 'parsing' }
ASMTPrincipalMassMarker >> parseMass: lines [

	[ lines removeFirst trim = 'Mass' ] assert.
	mass := self readDoubleOffTop: lines
]

{ #category : 'parsing' }
ASMTPrincipalMassMarker >> parseMomentOfInertias: lines [

	| colJpp |
	[ lines removeFirst trim = 'MomentOfInertias' ] assert.
	colJpp := self readColumnOfDoublesOffTop: lines.
	aJpp := StMDiagonalMatrix withAll: colJpp
]

{ #category : 'accessing' }
ASMTPrincipalMassMarker >> qEp [

	^ self aAOf eulerParameters
]
