Class {
	#name : 'ASMTSimulationParameters',
	#superclass : 'ASMTParameters',
	#instVars : [
		'tstart',
		'tend',
		'hmin',
		'hmax',
		'hout',
		'errorTol',
		'errorTolPosKine',
		'errorTolAccKine',
		'corAbsTol',
		'corRelTol',
		'intAbsTol',
		'intRelTol',
		'translationLimit',
		'rotationLimit',
		'iterMaxPosKine',
		'iterMaxAccKine',
		'iterMaxDyn',
		'orderMax'
	],
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'accessing' }
ASMTSimulationParameters >> corAbsTol [

	^ corAbsTol
]

{ #category : 'accessing' }
ASMTSimulationParameters >> corAbsTol: anObject [

	corAbsTol := anObject
]

{ #category : 'accessing' }
ASMTSimulationParameters >> corRelTol [

	^ corRelTol
]

{ #category : 'accessing' }
ASMTSimulationParameters >> corRelTol: anObject [

	corRelTol := anObject
]

{ #category : 'accessing' }
ASMTSimulationParameters >> errorTol: anObject [

	errorTol := anObject
]

{ #category : 'accessing' }
ASMTSimulationParameters >> errorTolAccKine [

	^ errorTolAccKine
]

{ #category : 'accessing' }
ASMTSimulationParameters >> errorTolAccKine: anObject [

	errorTolAccKine := anObject
]

{ #category : 'accessing' }
ASMTSimulationParameters >> errorTolPosKine [

	^ errorTolPosKine
]

{ #category : 'accessing' }
ASMTSimulationParameters >> errorTolPosKine: anObject [

	errorTolPosKine := anObject
]

{ #category : 'accessing' }
ASMTSimulationParameters >> hmax [

	^ hmax
]

{ #category : 'accessing' }
ASMTSimulationParameters >> hmax: anObject [

	hmax := anObject
]

{ #category : 'accessing' }
ASMTSimulationParameters >> hmin [

	^ hmin
]

{ #category : 'accessing' }
ASMTSimulationParameters >> hmin: anObject [

	hmin := anObject
]

{ #category : 'accessing' }
ASMTSimulationParameters >> hout [

	^ hout
]

{ #category : 'accessing' }
ASMTSimulationParameters >> hout: anObject [

	hout := anObject
]

{ #category : 'accessing' }
ASMTSimulationParameters >> intAbsTol [

	^ intAbsTol
]

{ #category : 'accessing' }
ASMTSimulationParameters >> intAbsTol: anObject [

	intAbsTol := anObject
]

{ #category : 'accessing' }
ASMTSimulationParameters >> intRelTol [

	^ intRelTol
]

{ #category : 'accessing' }
ASMTSimulationParameters >> intRelTol: anObject [

	intRelTol := anObject
]

{ #category : 'accessing' }
ASMTSimulationParameters >> iterMaxAccKine [

	^ iterMaxAccKine
]

{ #category : 'accessing' }
ASMTSimulationParameters >> iterMaxAccKine: anObject [

	iterMaxAccKine := anObject
]

{ #category : 'accessing' }
ASMTSimulationParameters >> iterMaxDyn [

	^ iterMaxDyn
]

{ #category : 'accessing' }
ASMTSimulationParameters >> iterMaxDyn: anObject [

	iterMaxDyn := anObject
]

{ #category : 'accessing' }
ASMTSimulationParameters >> iterMaxPosKine [

	^ iterMaxPosKine
]

{ #category : 'accessing' }
ASMTSimulationParameters >> iterMaxPosKine: anObject [

	iterMaxPosKine := anObject
]

{ #category : 'accessing' }
ASMTSimulationParameters >> orderMax [

	^ orderMax
]

{ #category : 'accessing' }
ASMTSimulationParameters >> orderMax: anObject [

	orderMax := anObject
]

{ #category : 'parsing' }
ASMTSimulationParameters >> parseASMT: lines [

	[ lines removeFirst trim = 'SimulationParameters' ] assert.
	self parsetstart: lines.
	self parsetend: lines.
	self parsehmin: lines.
	self parsehmax: lines.
	self parsehout: lines.
	self parseerrorTol: lines
]

{ #category : 'parsing' }
ASMTSimulationParameters >> parseerrorTol: lines [

	[ lines removeFirst trim = 'errorTol' ] assert.
	errorTol := self readDoubleOffTop: lines
]

{ #category : 'parsing' }
ASMTSimulationParameters >> parsehmax: lines [

	[ lines removeFirst trim = 'hmax' ] assert.
	hmax := self readDoubleOffTop: lines
]

{ #category : 'parsing' }
ASMTSimulationParameters >> parsehmin: lines [

	[ lines removeFirst trim = 'hmin' ] assert.
	hmin := self readDoubleOffTop: lines
]

{ #category : 'parsing' }
ASMTSimulationParameters >> parsehout: lines [

	[ lines removeFirst trim = 'hout' ] assert.
	hout := self readDoubleOffTop: lines
]

{ #category : 'parsing' }
ASMTSimulationParameters >> parsetend: lines [

	[ lines removeFirst trim = 'tend' ] assert.
	tend := self readDoubleOffTop: lines
]

{ #category : 'parsing' }
ASMTSimulationParameters >> parsetstart: lines [

	[ lines removeFirst trim = 'tstart' ] assert.
	tstart := self readDoubleOffTop: lines
]

{ #category : 'accessing' }
ASMTSimulationParameters >> rotationLimit [

	^ rotationLimit
]

{ #category : 'accessing' }
ASMTSimulationParameters >> rotationLimit: anObject [

	rotationLimit := anObject
]

{ #category : 'accessing' }
ASMTSimulationParameters >> tend [

	^ tend
]

{ #category : 'accessing' }
ASMTSimulationParameters >> tend: anObject [

	tend := anObject
]

{ #category : 'accessing' }
ASMTSimulationParameters >> translationLimit [

	translationLimit ifNil: [ translationLimit := 1.0e10 ].
	^ translationLimit
]

{ #category : 'accessing' }
ASMTSimulationParameters >> translationLimit: anObject [

	translationLimit := anObject
]

{ #category : 'accessing' }
ASMTSimulationParameters >> tstart [

	^ tstart
]

{ #category : 'accessing' }
ASMTSimulationParameters >> tstart: anObject [

	tstart := anObject
]
