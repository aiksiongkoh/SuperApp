Class {
	#name : 'ASMTSpatialItem',
	#superclass : 'ASMTItem',
	#instVars : [
		'rFfF',
		'aAFf'
	],
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'accessing' }
ASMTSpatialItem >> aAFf [

	^ aAFf
]

{ #category : 'accessing' }
ASMTSpatialItem >> aAOF [

	^ sup aAOf
]

{ #category : 'accessing' }
ASMTSpatialItem >> aAOf [

	^ self aAOF timesFullMatrix: aAFf
]

{ #category : 'accessing' }
ASMTSpatialItem >> aAaf [

	^ self aAaF timesFullMatrix: aAFf
]

{ #category : 'accessing' }
ASMTSpatialItem >> omeOFO [

	^ sup omeOfO
]

{ #category : 'accessing' }
ASMTSpatialItem >> omeOfO [

	^ self omeOFO
]

{ #category : 'parsing' }
ASMTSpatialItem >> parsePosition3D: lines [

	[ lines removeFirst trim = 'Position3D' ] assert.
	rFfF := self readColumnOfDoublesOffTop: lines
]

{ #category : 'parsing' }
ASMTSpatialItem >> parseRotationMatrix: lines [

	[ lines removeFirst trim = 'RotationMatrix' ] assert.
	aAFf := StMFullMatrix new: 3.
	1 to: 3 do: [ :i |
	aAFf at: i put: (self readRowOfDoublesOffTop: lines) ]
]

{ #category : 'accessing' }
ASMTSpatialItem >> rFfF [

	^ rFfF
]

{ #category : 'accessing' }
ASMTSpatialItem >> rOFO [

	^ sup rOfO
]

{ #category : 'accessing' }
ASMTSpatialItem >> rOfO [

	^ self rOFO + (self aAOF timesFullColumn: rFfF)
]

{ #category : 'accessing' }
ASMTSpatialItem >> vOFO [

	^ sup vOfO
]

{ #category : 'accessing' }
ASMTSpatialItem >> vOfO [

	| rFfO |
	rFfO := self aAOF timesFullColumn: rFfF.
	^ self vOFO + (self omeOFO cross: rFfO)
]

{ #category : 'accessing' }
ASMTSpatialItem >> vafa [

	| rFfa |
	rFfa := self aAaF timesFullColumn: rFfF.
	^ self vaFa + (self omeaFa cross: rFfa)
]
