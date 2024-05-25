Class {
	#name : 'ASMTPart',
	#superclass : 'ASMTRefContainer',
	#instVars : [
		'featureOrder',
		'principalMassMarker'
	],
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'accessing' }
ASMTPart >> aJpp [

	^ principalMassMarker aJpp
]

{ #category : 'adding' }
ASMTPart >> addFeatureOrder: feature [

	featureOrder add: feature.
	feature sup: self
]

{ #category : 'adding' }
ASMTPart >> addPrincipalMassMarker: marker [

	principalMassMarker := marker.
	marker sup: self
]

{ #category : 'accessing' }
ASMTPart >> alpOcmO [

	^ principalMassMarker alpOfO
]

{ #category : 'MbD' }
ASMTPart >> createMbDin: mbdAssemblyFrm [

	| units mbdPartFrm |
	units := self units.
	mbdPartFrm := SymPartFrame new.
	mbdObject := mbdPartFrm.
	mbdPartFrm name: name.
	mbdPartFrm m: self mass * units mass.
	mbdPartFrm aJ: self aJpp * units aJ.
	mbdPartFrm qX: self rOcmO * units length.
	mbdPartFrm qE: self qEp.
	mbdPartFrm vX: self vOcmO * units velocity.
	mbdPartFrm vOmega: self omeOcmO * units omega.
	mbdAssemblyFrm addPartFrm: mbdPartFrm
]

{ #category : 'accessing' }
ASMTPart >> fillMarkerSet: markerSet [

	refs do: [ :ref | ref fillMarkerSet: markerSet ].
	^ markerSet
]

{ #category : 'initialization' }
ASMTPart >> initialize [

	super initialize.
	featureOrder := OrderedCollection new
]

{ #category : 'accessing' }
ASMTPart >> mass [

	^ principalMassMarker mass
]

{ #category : 'accessing' }
ASMTPart >> omeOcmO [

	^ principalMassMarker omeOfO
]

{ #category : 'parsing' }
ASMTPart >> parseASMT: lines [

	[ lines removeFirst trim = 'Part' ] assert.
	self parseName: lines.
	self parsePosition3D: lines.
	self parseRotationMatrix: lines.
	self parseVelocity3D: lines.
	self parseOmega3D: lines.
	self parseFeatureOrder: lines.
	self parsePrincipalMassMarker: lines.
	self parseRefPoints: lines.
	self parseRefCurves: lines.
	self parseRefSurfaces: lines
]

{ #category : 'parsing' }
ASMTPart >> parseExtrusion: lines [

	| extrusion |
	extrusion := ASMTExtrusion new.
	self addFeatureOrder: extrusion.
	extrusion parseASMT: lines
]

{ #category : 'parsing' }
ASMTPart >> parseFeatureOrder: lines [

	[ lines removeFirst trim = 'FeatureOrder' ] assert.
	[ lines first trim = 'Extrusion' ] whileTrue: [
		self parseExtrusion: lines ]
]

{ #category : 'parsing' }
ASMTPart >> parsePartSeries: lines [

	| tokens partName |
	tokens := lines removeFirst substrings.
	[ 'PartSeries' = tokens first ] assert.
	partName := tokens second.
	[ self fullName = partName ] assert.
	self parseXs: lines.
	self parseYs: lines.
	self parseZs: lines.
	self parseBryantxs: lines.
	self parseBryantys: lines.
	self parseBryantzs: lines.
	self parseVXs: lines.
	self parseVYs: lines.
	self parseVZs: lines.
	self parseOmegaXs: lines.
	self parseOmegaYs: lines.
	self parseOmegaZs: lines.
	self parseAXs: lines.
	self parseAYs: lines.
	self parseAZs: lines.
	self parseAlphaXs: lines.
	self parseAlphaYs: lines.
	self parseAlphaZs: lines
]

{ #category : 'parsing' }
ASMTPart >> parsePrincipalMassMarker: lines [

	| marker |
	marker := ASMTPrincipalMassMarker new.
	self addPrincipalMassMarker: marker.
	marker parseASMT: lines
]

{ #category : 'accessing' }
ASMTPart >> qEp [

	^ principalMassMarker qEp
]

{ #category : 'accessing' }
ASMTPart >> rOcmO [

	^ principalMassMarker rOfO
]

{ #category : 'accessing' }
ASMTPart >> vOcmO [

	^ principalMassMarker vOfO
]
