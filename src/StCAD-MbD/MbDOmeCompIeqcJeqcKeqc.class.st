Class {
	#name : 'MbDOmeCompIeqcJeqcKeqc',
	#superclass : 'MbDOmeCompIeqcJecKeqc',
	#instVars : [
		'pomeiIeJeKepEJ',
		'pomeiIeJeKepEdotJ'
	],
	#category : 'StCAD-MbD-MbDKinematicIJ',
	#package : 'StCAD-MbD',
	#tag : 'MbDKinematicIJ'
}

{ #category : 'VisualWorks metadata' }
MbDOmeCompIeqcJeqcKeqc class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : 'instance creation' }
MbDOmeCompIeqcJeqcKeqc class >> withFrmI: afrmI frmJ: afrmJ frmK: afrmK axisK: integer [ 
	^(afrmI isMemberOf: MbDEndFrameqc)
		& (afrmJ isMemberOf: MbDEndFrameqc)
		ifTrue: [self new
				withFrmI: afrmI
				frmJ: afrmJ
				frmK: afrmK
				axisK: integer]
		ifFalse: [nil]
]

{ #category : 'calc' }
MbDOmeCompIeqcJeqcKeqc >> calcPostDynCorrectorIteration [
	| pomeIeJeOpEJ pomeIeJeOpEdotJ |
	super calcPostDynCorrectorIteration.
	pomeIeJeOpEJ := frmJ pomeOeOpE.
	pomeIeJeOpEdotJ := frmJ pomeOeOpEdot.
	pomeiIeJeKepEJ := aAjOKe dot: pomeIeJeOpEJ.
	pomeiIeJeKepEdotJ := aAjOKe dot: pomeIeJeOpEdotJ
]

{ #category : 'initialize-release' }
MbDOmeCompIeqcJeqcKeqc >> initialize [
	super initialize.
	pomeiIeJeKepEJ := StMFullRow new: 4.
	pomeiIeJeKepEdotJ := StMFullRow new: 4
]

{ #category : 'accessing' }
MbDOmeCompIeqcJeqcKeqc >> pvaluepEJ [
	^pomeiIeJeKepEJ
]

{ #category : 'accessing' }
MbDOmeCompIeqcJeqcKeqc >> pvaluepEdotJ [
	^pomeiIeJeKepEdotJ
]
