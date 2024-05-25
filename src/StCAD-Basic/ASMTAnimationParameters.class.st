Class {
	#name : 'ASMTAnimationParameters',
	#superclass : 'ASMTParameters',
	#instVars : [
		'nframe',
		'icurrent',
		'istart',
		'iend',
		'isForward',
		'framesPerSecond'
	],
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'parsing' }
ASMTAnimationParameters >> parseASMT: lines [

	[ lines removeFirst trim = 'AnimationParameters' ] assert.
	self parsenframe: lines.
	self parseicurrent: lines.
	self parseistart: lines.
	self parseiend: lines.
	self parseisForward: lines.
	self parseframesPerSecond: lines
]

{ #category : 'as yet unclassified' }
ASMTAnimationParameters >> parseframesPerSecond: lines [

	[ lines removeFirst trim = 'framesPerSecond' ] assert.
	framesPerSecond := self readIntegerOffTop: lines
]

{ #category : 'as yet unclassified' }
ASMTAnimationParameters >> parseicurrent: lines [

	[ lines removeFirst trim = 'icurrent' ] assert.
	icurrent := self readIntegerOffTop: lines
]

{ #category : 'as yet unclassified' }
ASMTAnimationParameters >> parseiend: lines [

	[ lines removeFirst trim = 'iend' ] assert.
	iend := self readIntegerOffTop: lines
]

{ #category : 'as yet unclassified' }
ASMTAnimationParameters >> parseisForward: lines [

	[ lines removeFirst trim = 'isForward' ] assert.
	isForward := self readBooleanOffTop: lines
]

{ #category : 'as yet unclassified' }
ASMTAnimationParameters >> parseistart: lines [

	[ lines removeFirst trim = 'istart' ] assert.
	istart := self readIntegerOffTop: lines
]

{ #category : 'as yet unclassified' }
ASMTAnimationParameters >> parsenframe: lines [

	[ lines removeFirst trim = 'nframe' ] assert.
	nframe := self readIntegerOffTop: lines
]
