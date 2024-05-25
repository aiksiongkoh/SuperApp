Class {
	#name : 'MbDVelCompIeqcJecOKeqc',
	#superclass : 'MbDVelCompIecJecOKeqc',
	#instVars : [
		'pviIeJeOKepEI',
		'pviIeJeOKepXdotI',
		'pviIeJeOKepEdotI'
	],
	#category : 'StCAD-MbD-MbDKinematicIJ',
	#package : 'StCAD-MbD',
	#tag : 'MbDKinematicIJ'
}

{ #category : 'VisualWorks metadata' }
MbDVelCompIeqcJecOKeqc class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : 'instance creation' }
MbDVelCompIeqcJecOKeqc class >> withFrmI: afrmI frmJ: afrmJ frmK: afrmK axisK: integer [ 
	^(afrmI isMemberOf: MbDEndFrameqc)
		& (afrmJ isMemberOf: MbDEndFramec) & (afrmK isMemberOf: MbDEndFrameqc)
		ifTrue: [self new
				withFrmI: afrmI
				frmJ: afrmJ
				frmK: afrmK
				axisK: integer]
		ifFalse: [nil]
]

{ #category : 'calc' }
MbDVelCompIeqcJecOKeqc >> calcPostDynCorrectorIteration [
	| mpvIeJeOpEI mpvIeJeOpEdotI mAjOKe |
	super calcPostDynCorrectorIteration.
	mpvIeJeOpEI := frmI pvOeOpE.
	mpvIeJeOpEdotI := frmI pvOeOpEdot.
	mAjOKe := aAjOKe negated.
	pviIeJeOKepEI := mAjOKe dot: mpvIeJeOpEI.
	pviIeJeOKepXdotI := mAjOKe transpose.
	pviIeJeOKepEdotI := mAjOKe dot: mpvIeJeOpEdotI
]

{ #category : 'initialize-release' }
MbDVelCompIeqcJecOKeqc >> initialize [
	super initialize.
	pviIeJeOKepEI := StMFullRow new: 4.
	pviIeJeOKepXdotI := StMFullRow new: 3.
	pviIeJeOKepEdotI := StMFullRow new: 4
]

{ #category : 'accessing' }
MbDVelCompIeqcJecOKeqc >> pvaluepEI [
	^pviIeJeOKepEI
]

{ #category : 'accessing' }
MbDVelCompIeqcJecOKeqc >> pvaluepEdotI [
	^pviIeJeOKepEdotI
]

{ #category : 'accessing' }
MbDVelCompIeqcJecOKeqc >> pvaluepXdotI [
	^pviIeJeOKepXdotI
]
