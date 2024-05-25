Class {
	#name : 'SymItemIJ',
	#superclass : 'SymItem',
	#instVars : [
		'endFrmI',
		'endFrmJ'
	],
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'initialize-release' }
SymItemIJ >> connectsI: frmI toJ: frmJ [

	endFrmI := frmI.
	endFrmJ := frmJ
]
