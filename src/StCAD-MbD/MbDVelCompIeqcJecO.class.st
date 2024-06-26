Class {
	#name : 'MbDVelCompIeqcJecO',
	#superclass : 'MbDVelCompIecJecO',
	#instVars : [
		'pvIeJeOipEI',
		'pvIeJeOipXdotI',
		'pvIeJeOipEdotI'
	],
	#category : 'StCAD-MbD-MbDKinematicIJ',
	#package : 'StCAD-MbD',
	#tag : 'MbDKinematicIJ'
}

{ #category : 'VisualWorks metadata' }
MbDVelCompIeqcJecO class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : 'instance creation' }
MbDVelCompIeqcJecO class >> withFrmI: afrmI frmJ: afrmJ axis: aaxis [ 
	^(afrmI isMemberOf: MbDEndFrameqc)
		& (afrmJ isMemberOf: MbDEndFramec)
		ifTrue: [self new
				withFrmI: afrmI
				frmJ: afrmJ
				axis: aaxis]
		ifFalse: [nil]
]

{ #category : 'calc' }
MbDVelCompIeqcJecO >> calcPostDynCorrectorIteration [
	super calcPostDynCorrectorIteration.
	pvIeJeOipEI := (frmI pvOeOpE at: axis) negated.
	pvIeJeOipEdotI := (frmI pvOeOpEdot at: axis) negated
]

{ #category : 'initialize-release' }
MbDVelCompIeqcJecO >> initialize [
	super initialize.
	pvIeJeOipEI := StMFullRow new: 4.
	pvIeJeOipXdotI := StMFullRow new: 3.
	pvIeJeOipEdotI := StMFullRow new: 4
]

{ #category : 'initialize-release' }
MbDVelCompIeqcJecO >> initializeLocally [
	pvIeJeOipXdotI := (StMFullRow zero: 3).
	pvIeJeOipXdotI at: axis put: -1.0
]

{ #category : 'accessing' }
MbDVelCompIeqcJecO >> pvaluepEI [
	^pvIeJeOipEI
]

{ #category : 'accessing' }
MbDVelCompIeqcJecO >> pvaluepEdotI [
	^pvIeJeOipEdotI
]

{ #category : 'accessing' }
MbDVelCompIeqcJecO >> pvaluepXdotI [
	^pvIeJeOipXdotI
]
