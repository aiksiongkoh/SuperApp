Class {
	#name : 'SymDispCompIJI',
	#superclass : 'SymDispCompIJ',
	#instVars : [
		'aAjOI',
		'axisI',
		'riIJI',
		'priIJIpXI',
		'priIJIpEI',
		'ppriIJIpXIpEI',
		'ppriIJIpEIpEI',
		'pAjOIpEIT',
		'ppAjOIpEIpEI',
		'priIJIpXJ',
		'priIJIpEJ',
		'ppriIJIpEIpXJ',
		'ppriIJIpEIpEJ',
		'ppriIJIpEJpEJ',
		'priIJIpt',
		'ppriIJIpXIpt',
		'ppriIJIpEIpt',
		'ppriIJIpXJpt',
		'ppriIJIpEJpt',
		'ppriIJIptpt',
		'ppriIJIpXIpXI',
		'ppriIJIpXIpXJ',
		'ppriIJIpXIpEJ',
		'ppriIJIpXJpXJ',
		'ppriIJIpXJpEJ'
	],
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'calc' }
SymDispCompIJI >> calcKineIJ [

	aAjOI := endFrmI aAjOe: axisI.
	rIJO := endFrmJ rOeO - endFrmI rOeO.
	riIJI := (aAjOI dot: rIJO) simplified.
	kineIJ := riIJI
]

{ #category : 'evaluating' }
SymDispCompIJI >> value [

	^ riIJI
]

{ #category : 'instance creation' }
SymDispCompIJI >> withFrmI: eFrmI frmJ: eFrmJ axis: aaxis [

	super withFrmI: eFrmI frmJ: eFrmJ.
	axisI := aaxis
]
