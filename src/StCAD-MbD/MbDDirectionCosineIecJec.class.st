"
ijk_I := dA * ijk_J
ijk_I := aAIeJe * ijk_J
Component of aAIeJe
aIJ, aIeJe, aAiIejJe or aAIeJeij
Axes axisI and axisJ
"
Class {
	#name : 'MbDDirectionCosineIecJec',
	#superclass : 'MbDKinematicIeJe',
	#instVars : [
		'aAijIeJe',
		'axisI',
		'axisJ',
		'aAjOIe',
		'aAjOJe'
	],
	#category : 'StCAD-MbD-MbDKinematicIJ',
	#package : 'StCAD-MbD',
	#tag : 'MbDKinematicIJ'
}

{ #category : 'VisualWorks metadata' }
MbDDirectionCosineIecJec class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : 'instance creation' }
MbDDirectionCosineIecJec class >> withFrmI: afrmI frmJ: afrmJ axisI: aaxisI axisJ: aaxisJ [ 
	| instance |
	self allSubclasses
		do: 
			[:subclass | 
			instance := subclass
						withFrmI: afrmI
						frmJ: afrmJ
						axisI: aaxisI
						axisJ: aaxisJ.
			instance notNil ifTrue: [^instance]]
]

{ #category : 'accessing' }
MbDDirectionCosineIecJec >> aAijIeJe [
	^aAijIeJe
]

{ #category : 'accessing' }
MbDDirectionCosineIecJec >> axisI [
	^axisI
]

{ #category : 'accessing' }
MbDDirectionCosineIecJec >> axisI: integer [ 
	axisI := integer
]

{ #category : 'accessing' }
MbDDirectionCosineIecJec >> axisJ [
	^axisJ
]

{ #category : 'accessing' }
MbDDirectionCosineIecJec >> axisJ: integer [ 
	axisJ := integer
]

{ #category : 'calc' }
MbDDirectionCosineIecJec >> calcPostDynCorrectorIteration [
	aAjOIe := frmI aAjOe: axisI.
	aAjOJe := frmJ aAjOe: axisJ.
	aAijIeJe := aAjOIe dot: aAjOJe
]

{ #category : 'accessing' }
MbDDirectionCosineIecJec >> value [
	^aAijIeJe
]

{ #category : 'initialize-release' }
MbDDirectionCosineIecJec >> withFrmI: afrmI frmJ: afrmJ axisI: aaxisI axisJ: aaxisJ [ 
	frmI := afrmI.
	frmJ := afrmJ.
	axisI := aaxisI.
	axisJ := aaxisJ
]
