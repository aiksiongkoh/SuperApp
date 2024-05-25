Class {
	#name : 'ASMTRefPoint',
	#superclass : 'ASMTRefItem',
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'parsing' }
ASMTRefPoint >> parseASMT: lines [

	[ lines removeFirst trim = 'RefPoint' ] assert.
	self parsePosition3D: lines.
	self parseRotationMatrix: lines.
	self parseMarkers: lines
]

{ #category : 'parsing' }
ASMTRefPoint >> parseMarker: lines [

	| marker |
	marker := ASMTMarker new.
	self addMarker: marker.
	marker parseASMT: lines
]

{ #category : 'parsing' }
ASMTRefPoint >> parseMarkers: lines [

	[ lines removeFirst trim = 'Markers' ] assert.
	[ lines first trim = 'Marker' ] whileTrue: [ self parseMarker: lines ]
]
