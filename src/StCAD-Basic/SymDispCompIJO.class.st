Class {
	#name : 'SymDispCompIJO',
	#superclass : 'SymDispCompIJ',
	#instVars : [
		'axisO',
		'riIJO',
		'priIJOpXI',
		'priIJOpEI',
		'priIJOpXJ',
		'priIJOpEJ',
		'ppriIJOpEIpEI',
		'ppriIJOpEJpEJ',
		'priIJOpt',
		'ppriIJOpEIpt',
		'ppriIJOptpt'
	],
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'calc' }
SymDispCompIJO >> calcKineIJ [

	| riOI riOJ |
	riOI := endFrmI rOeO at: axisO.
	riOJ := endFrmJ rOeO at: axisO.
	riIJO := (riOJ - riOI) simplified.
	kineIJ := riIJO
]

{ #category : 'calc' }
SymDispCompIJO >> calcPostDynCorrectorIteration [
	self shouldBeImplemented.
]

{ #category : 'accessing' }
SymDispCompIJO >> priIeJeOpEI [

	^ priIJOpEI
]

{ #category : 'accessing' }
SymDispCompIJO >> priIeJeOpEJ [

	^ priIJOpEJ
]

{ #category : 'evaluating' }
SymDispCompIJO >> value [

	^ riIJO
]

{ #category : 'instance creation' }
SymDispCompIJO >> withFrmI: eFrmI frmJ: eFrmJ axis: aaxis [

	super withFrmI: eFrmI frmJ: eFrmJ.
	axisO := aaxis
]
