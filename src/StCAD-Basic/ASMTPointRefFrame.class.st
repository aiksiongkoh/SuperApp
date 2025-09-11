Class {
	#name : 'ASMTPointRefFrame',
	#superclass : 'ASMTRefFrame',
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'MbD' }
ASMTPointRefFrame >> createMbDin: mbdPartFrm [
	"
	Note: mbdPartFrm is at cm and principal axes.
	rpmp := rpcmp + aApcm * rcmmcm
	rcmmcm := aApcmT * (rpmp - rpcmp)
	aApm := aApcm * aAcmm
	aAcmm := aApcmT * aApm
	"

	| units mbdUnits mbdMarkerFrm rpmp cmFrm rpcmp aApcmT rcmmcm aApm aAcmm |
	units := self units.
	mbdUnits := self mbdUnits.
	mbdMarkerFrm := mbdPartFrm isPartFrame
		                ifTrue: [ SymPointMarkerFrame new ]
		                ifFalse: [ SymAssemblyPointMarkerFrame new ].
	mbdObject := mbdMarkerFrm.
	mbdMarkerFrm name: name.
	rpmp := rFfF.
	aApm := aAFf.
	cmFrm := self principalMassFrame.
	cmFrm
		ifNil: [
				rcmmcm := rpmp.
				aAcmm := aApm ]
		ifNotNil: [
				rpcmp := cmFrm rFfF.
				aApcmT := cmFrm aAFf transpose.
				rcmmcm := aApcmT timesFullColumn: rpmp - rpcmp.
				aAcmm := aApcmT timesFullMatrix: aApm ].
	mbdMarkerFrm rFfF: rcmmcm * units length / mbdUnits length.
	mbdMarkerFrm aAFf: aAcmm.
	mbdPartFrm addMarkerFrm: mbdMarkerFrm.
	markers asSortedCollection: [ :a :b | a name <= b name ].
	markers do: [ :item | item createMbDin: mbdMarkerFrm ]
]

{ #category : 'accessing' }
ASMTPointRefFrame >> name [

	[ markers size == 1 ] assert.
	^ markers first name
]

{ #category : 'parsing' }
ASMTPointRefFrame >> parseASMT: lines [

	[ lines removeFirst trim = 'RefPoint' ] assert.
	self parsePosition3D: lines.
	self parseRotationMatrix: lines.
	self parseMarkers: lines
]

{ #category : 'parsing' }
ASMTPointRefFrame >> parseMarker: lines [

	| marker |
	marker := ASMTMarkerFrame new.
	self addMarker: marker.
	marker parseASMT: lines
]

{ #category : 'parsing' }
ASMTPointRefFrame >> parseMarkers: lines [

	[ lines removeFirst trim = 'Markers' ] assert.
	[ lines first trim = 'Marker' ] whileTrue: [ self parseMarker: lines ]
]
