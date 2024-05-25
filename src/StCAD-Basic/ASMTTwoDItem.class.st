Class {
	#name : 'ASMTTwoDItem',
	#superclass : 'ASMTItem',
	#instVars : [
		'rFfF',
		'angle'
	],
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'parsing' }
ASMTTwoDItem >> parseAngle: lines [

	[ lines removeFirst trim = 'Angle' ] assert.
	angle := self readDoubleOffTop: lines
]

{ #category : 'parsing' }
ASMTTwoDItem >> parsePosition2D: lines [

	[ lines removeFirst trim = 'Position2D' ] assert.
	rFfF := self readColumnOfDoublesOffTop: lines
]
