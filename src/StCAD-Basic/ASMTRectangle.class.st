Class {
	#name : 'ASMTRectangle',
	#superclass : 'ASMTTwoDItem',
	#instVars : [
		'xLength',
		'yLength'
	],
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'parsing' }
ASMTRectangle >> parseASMT: lines [

	[ lines removeFirst trim = 'Rectangle' ] assert.
	self parsePosition2D: lines.
	self parseAngle: lines.
	self parsexLength: lines.
	self parseyLength: lines
]

{ #category : 'as yet unclassified' }
ASMTRectangle >> parsexLength: lines [

	[ lines removeFirst trim = 'xLength' ] assert.
	xLength := self readDoubleOffTop: lines
]

{ #category : 'as yet unclassified' }
ASMTRectangle >> parseyLength: lines [

	[ lines removeFirst trim = 'yLength' ] assert.
	yLength := self readDoubleOffTop: lines
]
