Class {
	#name : 'ASMTSketch',
	#superclass : 'ASMTSpatialItem',
	#instVars : [
		'graphics'
	],
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'adding' }
ASMTSketch >> addGraphic: graphic [

	graphics add: graphic.
	graphic sup: self
]

{ #category : 'initialization' }
ASMTSketch >> initialize [

	super initialize.
	graphics := OrderedCollection new
]

{ #category : 'parsing' }
ASMTSketch >> parseASMT: lines [

	[ lines removeFirst trim = 'Sketch' ] assert.
	self parseName: lines.
	self parsePosition3D: lines.
	self parseRotationMatrix: lines.
	self parseGraphics: lines
]

{ #category : 'parsing' }
ASMTSketch >> parseCircle: lines [

	| circle |
	circle := ASMTCircle new.
	self addGraphic: circle.
	circle parseASMT: lines
]

{ #category : 'parsing' }
ASMTSketch >> parseGraphics: lines [

	| continue type |
	[ lines removeFirst trim = 'Graphics' ] assert.
	continue := true.
	[ continue ] whileTrue: [
		type := lines first trim.
		type = 'Rectangle'
			ifTrue: [ self parseRectangle: lines ]
			ifFalse: [
				type = 'Circle'
					ifTrue: [ self parseCircle: lines ]
					ifFalse: [ continue := false ] ] ]
]

{ #category : 'parsing' }
ASMTSketch >> parseRectangle: lines [

	| rectangle |
	rectangle := ASMTRectangle new.
	self addGraphic: rectangle.
	rectangle parseASMT: lines
]
