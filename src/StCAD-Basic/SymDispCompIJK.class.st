Class {
	#name : 'SymDispCompIJK',
	#superclass : 'SymDispCompIJ',
	#instVars : [
		'endFrmK',
		'axisK',
		'aAjOK',
		'riIJK',
		'priIJKpEK',
		'ppriIJKpEKpEK',
		'pAjOKpEKT',
		'ppAjOKpEKpEK',
		'priIJKpXI',
		'priIJKpEI',
		'ppriIJKpXIpEK',
		'ppriIJKpEIpEI',
		'ppriIJKepEIpEK',
		'priIJKpXJ',
		'priIJKpEJ',
		'ppriIJKpXJpEK',
		'ppriIJKpEJpEJ',
		'ppriIJKpEJpEK',
		'priIJKpt',
		'ppriIJKpXIpt',
		'ppriIJKpEIpt',
		'ppriIJKpXJpt',
		'ppriIJKpEJpt',
		'ppriIJKpEKpt',
		'ppriIJKptpt'
	],
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'calc' }
SymDispCompIJK >> calcAll [

	self notYetImplemented
]

{ #category : 'calc' }
SymDispCompIJK >> calcPostDynCorrectorIteration [

	| ppAjOKepEKipEK ppriIeJeKepEKipEK ppriIeJeKepEKipEKj |
	self halt.
	rIJO := endFrmJ rOeO - endFrmI rOeO.
	endFrmK ifNil: [
		riIJK := rIJO at: axisK.
		ppriIJKpEKpEK := nil.
		ppAjOKpEKpEK := nil.
		^ self ].
	aAjOK := endFrmK aAjOe: axisK.
	riIJK := aAjOK dot: rIJO.
	pAjOKpEKT := endFrmK pAjOepET: axisK.
	ppAjOKpEKpEK := endFrmK ppAjOepEpE: axisK.
	1 to: 4 do: [ :i | priIJKpEK at: i put: ((pAjOKpEKT at: i) dot: rIJO) ].
	1 to: 4 do: [ :i |
		ppAjOKepEKipEK := ppAjOKpEKpEK at: i.
		ppriIeJeKepEKipEK := ppriIJKpEKpEK at: i.
		ppriIeJeKepEKipEK at: i put: ((ppAjOKepEKipEK at: i) dot: rIJO).
		i + 1 to: 4 do: [ :j |
			ppriIeJeKepEKipEKj := (ppAjOKepEKipEK at: i) dot: rIJO.
			ppriIeJeKepEKipEK at: j put: ppriIeJeKepEKipEKj.
			ppriIJKpEKpEK at: j and: i put: ppriIeJeKepEKipEKj ] ]
]

{ #category : 'evaluating' }
SymDispCompIJK >> value [

	^ riIJK
]

{ #category : 'instance creation' }
SymDispCompIJK >> withFrmI: eFrmI frmJ: eFrmJ axis: aaxis [

	super withFrmI: eFrmI frmJ: eFrmJ.
	endFrmK := nil.
	axisK := aaxis
]

{ #category : 'as yet unclassified' }
SymDispCompIJK >> withFrmI: eFrmI frmJ: eFrmJ frmK: eFrmK axis: aaxis [

	super withFrmI: eFrmI frmJ: eFrmJ.
	endFrmK := eFrmK.
	axisK := aaxis.
	self calcAll
]
