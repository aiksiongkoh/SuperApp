Class {
	#name : 'ASMTCircle',
	#superclass : 'ASMTTwoDItem',
	#instVars : [
		'radius'
	],
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'parsing' }
ASMTCircle >> parseASMT: lines [

	[ lines removeFirst trim = 'Circle' ] assert.
	self parsePosition2D: lines.
	self parseAngle: lines.
	self parseRadius: lines
]

{ #category : 'parsing' }
ASMTCircle >> parseRadius: lines [

	[ lines removeFirst trim = 'Radius' ] assert.
	radius := self readDoubleOffTop: lines
]
