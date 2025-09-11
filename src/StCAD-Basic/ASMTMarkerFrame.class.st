Class {
	#name : 'ASMTMarkerFrame',
	#superclass : 'ASMTMovingItem',
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'MbD' }
ASMTMarkerFrame >> createMbDin: mbdMarkerFrm [

	| units mbdUnits mbdEndFrm |
	units := self units.
	mbdUnits := self mbdUnits.
	mbdEndFrm := mbdMarkerFrm newEndFramec.
	mbdObject := mbdEndFrm.
	mbdEndFrm name: name.
	mbdEndFrm rmem: rFfF * units length / mbdUnits length.
	mbdEndFrm theme: aAFf bryantAngles.
	mbdMarkerFrm addEndFrm: mbdEndFrm
]

{ #category : 'parsing' }
ASMTMarkerFrame >> parseASMT: lines [

	[ lines removeFirst trim = 'Marker' ] assert.
	self parseName: lines.
	self parsePosition3D: lines.
	self parseRotationMatrix: lines
]
