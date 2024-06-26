Class {
	#name : 'MbDDispCompIeqcJecO',
	#superclass : 'MbDDispCompIecJecO',
	#instVars : [
		'priIeJeOpXI',
		'priIeJeOpEI',
		'ppriIeJeOpEIpEI'
	],
	#category : 'StCAD-MbD-MbDKinematicIJ',
	#package : 'StCAD-MbD',
	#tag : 'MbDKinematicIJ'
}

{ #category : 'VisualWorks metadata' }
MbDDispCompIeqcJecO class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : 'instance creation' }
MbDDispCompIeqcJecO class >> withFrmI: afrmI frmJ: afrmJ axis: i [ 
	^(afrmI isMemberOf: MbDEndFrameqc)
		& (afrmJ isMemberOf: MbDEndFramec)
		ifTrue: [self new
				withFrmI: afrmI
				frmJ: afrmJ
				axis: i]
		ifFalse: [nil]
]

{ #category : 'calc' }
MbDDispCompIeqcJecO >> calcPostDynCorrectorIteration [
	super calcPostDynCorrectorIteration.
	priIeJeOpEI := (frmI priOeOpE: axis) negated
]

{ #category : 'initialize-release' }
MbDDispCompIeqcJecO >> initializeGlobally [
	super initializeGlobally.
	priIeJeOpXI := (StMFullRow zero: 3).
	priIeJeOpXI at: axis put: -1.0.
	ppriIeJeOpEIpEI := (frmI ppriOeOpEpE: axis) negated
]

{ #category : 'accessing' }
MbDDispCompIeqcJecO >> ppriIeJeOpEIpEI [
	^ppriIeJeOpEIpEI
]

{ #category : 'accessing' }
MbDDispCompIeqcJecO >> ppvaluepEIpEI [
	^ppriIeJeOpEIpEI
]

{ #category : 'accessing' }
MbDDispCompIeqcJecO >> priIeJeOpEI [
	^priIeJeOpEI
]

{ #category : 'accessing' }
MbDDispCompIeqcJecO >> pvaluepEI [
	^priIeJeOpEI
]

{ #category : 'accessing' }
MbDDispCompIeqcJecO >> pvaluepXI [
	^priIeJeOpXI
]
