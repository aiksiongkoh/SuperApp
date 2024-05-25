Class {
	#name : 'ASMTMovingItem',
	#superclass : 'ASMTSpatialItem',
	#instVars : [
		'vFfF',
		'omeFfF',
		'aFfF',
		'alpFfF',
		'iBryantxs',
		'iBryantys',
		'iBryantzs',
		'iXs',
		'iYs',
		'iZs',
		'iVXs',
		'iVYs',
		'iVZs',
		'iOmegaXs',
		'iOmegaYs',
		'iOmegaZs',
		'iAXs',
		'iAYs',
		'iAZs',
		'iAlphaXs',
		'iAlphaYs',
		'iAlphaZs'
	],
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'accessing' }
ASMTMovingItem >> omeOfO [

	^ self omeOFO + (self aAOF timesFullColumn: omeFfF)
]

{ #category : 'parsing' }
ASMTMovingItem >> parseAXs: lines [

	| tokens |
	tokens := lines removeFirst substrings asOrderedCollection.
	[ tokens removeFirst trim = 'AX' ] assert.
	iAXs := OrderedCollection ofSize: tokens size.
	1 to: tokens size do: [ :i |
	iAXs at: i put: (Float readFrom: tokens removeFirst trim) ]
]

{ #category : 'parsing' }
ASMTMovingItem >> parseAYs: lines [

	| tokens |
	tokens := lines removeFirst substrings asOrderedCollection.
	[ tokens removeFirst trim = 'AY' ] assert.
	iAYs := OrderedCollection ofSize: tokens size.
	1 to: tokens size do: [ :i |
	iAYs at: i put: (Float readFrom: tokens removeFirst trim) ]
]

{ #category : 'parsing' }
ASMTMovingItem >> parseAZs: lines [

	| tokens |
	tokens := lines removeFirst substrings asOrderedCollection.
	[ tokens removeFirst trim = 'AZ' ] assert.
	iAZs := OrderedCollection ofSize: tokens size.
	1 to: tokens size do: [ :i |
	iAZs at: i put: (Float readFrom: tokens removeFirst trim) ]
]

{ #category : 'parsing' }
ASMTMovingItem >> parseAlphaXs: lines [

	| tokens |
	tokens := lines removeFirst substrings asOrderedCollection.
	[ tokens removeFirst trim = 'AlphaX' ] assert.
	iAlphaXs := OrderedCollection ofSize: tokens size.
	1 to: tokens size do: [ :i |
	iAlphaXs at: i put: (Float readFrom: tokens removeFirst trim) ]
]

{ #category : 'parsing' }
ASMTMovingItem >> parseAlphaYs: lines [

	| tokens |
	tokens := lines removeFirst substrings asOrderedCollection.
	[ tokens removeFirst trim = 'AlphaY' ] assert.
	iAlphaYs := OrderedCollection ofSize: tokens size.
	1 to: tokens size do: [ :i |
	iAlphaYs at: i put: (Float readFrom: tokens removeFirst trim) ]
]

{ #category : 'parsing' }
ASMTMovingItem >> parseAlphaZs: lines [

	| tokens |
	tokens := lines removeFirst substrings asOrderedCollection.
	[ tokens removeFirst trim = 'AlphaZ' ] assert.
	iAlphaZs := OrderedCollection ofSize: tokens size.
	1 to: tokens size do: [ :i |
	iAlphaZs at: i put: (Float readFrom: tokens removeFirst trim) ]
]

{ #category : 'parsing' }
ASMTMovingItem >> parseBryantxs: lines [

	| tokens |
	tokens := lines removeFirst substrings asOrderedCollection.
	[ tokens removeFirst trim = 'Bryantx' ] assert.
	iBryantxs := OrderedCollection ofSize: tokens size.
	1 to: tokens size do: [ :i |
	iBryantxs at: i put: (Float readFrom: tokens removeFirst trim) ]
]

{ #category : 'parsing' }
ASMTMovingItem >> parseBryantys: lines [

	| tokens |
	tokens := lines removeFirst substrings asOrderedCollection.
	[ tokens removeFirst trim = 'Bryanty' ] assert.
	iBryantys := OrderedCollection ofSize: tokens size.
	1 to: tokens size do: [ :i |
	iBryantys at: i put: (Float readFrom: tokens removeFirst trim) ]
]

{ #category : 'parsing' }
ASMTMovingItem >> parseBryantzs: lines [

	| tokens |
	tokens := lines removeFirst substrings asOrderedCollection.
	[ tokens removeFirst trim = 'Bryantz' ] assert.
	iBryantzs := OrderedCollection ofSize: tokens size.
	1 to: tokens size do: [ :i |
	iBryantzs at: i put: (Float readFrom: tokens removeFirst trim) ]
]

{ #category : 'parsing' }
ASMTMovingItem >> parseOmega3D: lines [

	[ lines removeFirst trim = 'Omega3D' ] assert.
	omeFfF := self readColumnOfDoublesOffTop: lines
]

{ #category : 'parsing' }
ASMTMovingItem >> parseOmegaXs: lines [

	| tokens |
	tokens := lines removeFirst substrings asOrderedCollection.
	[ tokens removeFirst trim = 'OmegaX' ] assert.
	iOmegaXs := OrderedCollection ofSize: tokens size.
	1 to: tokens size do: [ :i |
	iOmegaXs at: i put: (Float readFrom: tokens removeFirst trim) ]
]

{ #category : 'parsing' }
ASMTMovingItem >> parseOmegaYs: lines [

	| tokens |
	tokens := lines removeFirst substrings asOrderedCollection.
	[ tokens removeFirst trim = 'OmegaY' ] assert.
	iOmegaYs := OrderedCollection ofSize: tokens size.
	1 to: tokens size do: [ :i |
	iOmegaYs at: i put: (Float readFrom: tokens removeFirst trim) ]
]

{ #category : 'parsing' }
ASMTMovingItem >> parseOmegaZs: lines [

	| tokens |
	tokens := lines removeFirst substrings asOrderedCollection.
	[ tokens removeFirst trim = 'OmegaZ' ] assert.
	iOmegaZs := OrderedCollection ofSize: tokens size.
	1 to: tokens size do: [ :i |
	iOmegaZs at: i put: (Float readFrom: tokens removeFirst trim) ]
]

{ #category : 'parsing' }
ASMTMovingItem >> parseVXs: lines [

	| tokens |
	tokens := lines removeFirst substrings asOrderedCollection.
	[ tokens removeFirst trim = 'VX' ] assert.
	iVXs := OrderedCollection ofSize: tokens size.
	1 to: tokens size do: [ :i |
	iVXs at: i put: (Float readFrom: tokens removeFirst trim) ]
]

{ #category : 'parsing' }
ASMTMovingItem >> parseVYs: lines [

	| tokens |
	tokens := lines removeFirst substrings asOrderedCollection.
	[ tokens removeFirst trim = 'VY' ] assert.
	iVYs := OrderedCollection ofSize: tokens size.
	1 to: tokens size do: [ :i |
	iVYs at: i put: (Float readFrom: tokens removeFirst trim) ]
]

{ #category : 'parsing' }
ASMTMovingItem >> parseVZs: lines [

	| tokens |
	tokens := lines removeFirst substrings asOrderedCollection.
	[ tokens removeFirst trim = 'VZ' ] assert.
	iVZs := OrderedCollection ofSize: tokens size.
	1 to: tokens size do: [ :i |
	iVZs at: i put: (Float readFrom: tokens removeFirst trim) ]
]

{ #category : 'parsing' }
ASMTMovingItem >> parseVelocity3D: lines [

	[ lines removeFirst trim = 'Velocity3D' ] assert.
	vFfF := self readColumnOfDoublesOffTop: lines
]

{ #category : 'parsing' }
ASMTMovingItem >> parseXs: lines [

	| tokens |
	tokens := lines removeFirst substrings asOrderedCollection.
	[ tokens removeFirst trim = 'X' ] assert.
	iXs := OrderedCollection ofSize: tokens size.
	1 to: tokens size do: [ :i |
	iXs at: i put: (Float readFrom: tokens removeFirst trim) ]
]

{ #category : 'parsing' }
ASMTMovingItem >> parseYs: lines [

	| tokens |
	tokens := lines removeFirst substrings asOrderedCollection.
	[ tokens removeFirst trim = 'Y' ] assert.
	iYs := OrderedCollection ofSize: tokens size.
	1 to: tokens size do: [ :i |
	iYs at: i put: (Float readFrom: tokens removeFirst trim) ]
]

{ #category : 'parsing' }
ASMTMovingItem >> parseZs: lines [

	| tokens |
	tokens := lines removeFirst substrings asOrderedCollection.
	[ tokens removeFirst trim = 'Z' ] assert.
	iZs := OrderedCollection ofSize: tokens size.
	1 to: tokens size do: [ :i |
	iZs at: i put: (Float readFrom: tokens removeFirst trim) ]
]

{ #category : 'accessing' }
ASMTMovingItem >> vOfO [

	^ super vOfO + (self aAOF timesFullColumn: vFfF)
]
