Class {
	#name : 'ASMTExtrusion',
	#superclass : 'ASMTItem',
	#instVars : [
		'zStart',
		'zEnd',
		'sketch'
	],
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'adding' }
ASMTExtrusion >> addSketch: aSketch [

	sketch := aSketch.
	aSketch sup: self
]

{ #category : 'parsing' }
ASMTExtrusion >> parseASMT: lines [

	[ lines removeFirst trim = 'Extrusion' ] assert.
	self parsezStart: lines.
	self parsezEnd: lines.
	self parseSketch: lines
]

{ #category : 'parsing' }
ASMTExtrusion >> parseSketch: lines [

	| sketch |
	sketch := ASMTSketch new.
	self addSketch: sketch.
	sketch parseASMT: lines
]

{ #category : 'as yet unclassified' }
ASMTExtrusion >> parsezEnd: lines [

	[ lines removeFirst trim = 'zEnd' ] assert.
	zEnd := self readDoubleOffTop: lines
]

{ #category : 'as yet unclassified' }
ASMTExtrusion >> parsezStart: lines [

	[ lines removeFirst trim = 'zStart' ] assert.
	zStart := self readDoubleOffTop: lines
]
