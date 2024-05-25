Class {
	#name : 'ASMTRotationalMotion',
	#superclass : 'ASMTMotion',
	#instVars : [
		'rotationZ'
	],
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'accessing' }
ASMTRotationalMotion class >> mbdClass [

	^ SymZRotation
]

{ #category : 'parsing' }
ASMTRotationalMotion >> parseASMT: lines [

	[ lines removeFirst trim = 'RotationalMotion' ] assert.
	self parseName: lines.
	self parseMotionJoint: lines.
	self parseRotationZ: lines
]

{ #category : 'parsing' }
ASMTRotationalMotion >> parseRotationZ: lines [

	[ lines removeFirst trim = 'RotationZ' ] assert.
	rotationZ := lines removeFirst trim
]
