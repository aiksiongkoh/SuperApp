Class {
	#name : 'MbDVelCompIeqcJeqcOKeqc',
	#superclass : 'MbDVelCompIeqcJecOKeqc',
	#instVars : [
		'pviIeJeOKepEJ',
		'pviIeJeOKepXdotJ',
		'pviIeJeOKepEdotJ'
	],
	#category : 'StCAD-MbD-MbDKinematicIJ',
	#package : 'StCAD-MbD',
	#tag : 'MbDKinematicIJ'
}

{ #category : 'VisualWorks metadata' }
MbDVelCompIeqcJeqcOKeqc class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : 'instance creation' }
MbDVelCompIeqcJeqcOKeqc class >> withFrmI: afrmI frmJ: afrmJ frmK: afrmK axisK: integer [ 
	^(afrmI isMemberOf: MbDEndFrameqc)
		& (afrmJ isMemberOf: MbDEndFrameqc) & (afrmK isMemberOf: MbDEndFrameqc)
		ifTrue: [self new
				withFrmI: afrmI
				frmJ: afrmJ
				frmK: afrmK
				axisK: integer]
		ifFalse: [nil]
]

{ #category : 'calc' }
MbDVelCompIeqcJeqcOKeqc >> calcPostDynCorrectorIteration [
	| pvIeJeOpEJ pvIeJeOpEdotJ |
	super calcPostDynCorrectorIteration.
	pvIeJeOpEJ := frmJ pvOeOpE.
	pvIeJeOpEdotJ := frmJ pvOeOpEdot.
	pviIeJeOKepEJ := aAjOKe dot: pvIeJeOpEJ.
	pviIeJeOKepXdotJ := aAjOKe transpose.
	pviIeJeOKepEdotJ := aAjOKe dot: pvIeJeOpEdotJ
]

{ #category : 'initialize-release' }
MbDVelCompIeqcJeqcOKeqc >> initialize [
	super initialize.
	pviIeJeOKepEJ := StMFullRow new: 4.
	pviIeJeOKepXdotJ := StMFullRow new: 3.
	pviIeJeOKepEdotJ := StMFullRow new: 4
]

{ #category : 'accessing' }
MbDVelCompIeqcJeqcOKeqc >> pvaluepEJ [
	^pviIeJeOKepEJ
]

{ #category : 'accessing' }
MbDVelCompIeqcJeqcOKeqc >> pvaluepEdotJ [
	^pviIeJeOKepEdotJ
]

{ #category : 'accessing' }
MbDVelCompIeqcJeqcOKeqc >> pvaluepXdotJ [
	^pviIeJeOKepXdotJ
]
