Class {
	#name : 'SymDirectionCosineIJ',
	#superclass : 'SymKinematicIJ',
	#instVars : [
		'axisI',
		'axisJ',
		'aAijIJ'
	],
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'as yet unclassified' }
SymDirectionCosineIJ >> calcKineIJ [

	| aAjOIe aAjOJe |
	aAjOIe := endFrmI aAjOe: axisI.
	aAjOJe := endFrmJ aAjOe: axisJ.
	aAijIJ := (aAjOIe dot: aAjOJe) simplified.
	kineIJ := aAijIJ
]

{ #category : 'evaluating' }
SymDirectionCosineIJ >> value [

	^ aAijIJ
]

{ #category : 'instance creation' }
SymDirectionCosineIJ >> withFrmI: eFrmI frmJ: eFrmJ axisI: aaxisI axisJ: aaxisJ [

	super withFrmI: eFrmI frmJ: eFrmJ.
	axisI := aaxisI.
	axisJ := aaxisJ
]
