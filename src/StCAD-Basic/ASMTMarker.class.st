Class {
	#name : 'ASMTMarker',
	#superclass : 'ASMTMovingItem',
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'parsing' }
ASMTMarker >> parseASMT: lines [

	[ lines removeFirst trim = 'Marker' ] assert.
	self parseName: lines.
	self parsePosition3D: lines.
	self parseRotationMatrix: lines
]
