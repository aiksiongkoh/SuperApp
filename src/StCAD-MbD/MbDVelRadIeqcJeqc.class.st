Class {
	#name : 'MbDVelRadIeqcJeqc',
	#superclass : 'MbDVelRadIeqcJec',
	#instVars : [
		'pvIeJepXJ',
		'pvIeJepEJ',
		'pvIeJepXdotJ',
		'pvIeJepEdotJ'
	],
	#category : 'StCAD-MbD-MbDKinematicIJ',
	#package : 'StCAD-MbD',
	#tag : 'MbDKinematicIJ'
}

{ #category : 'VisualWorks metadata' }
MbDVelRadIeqcJeqc class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : 'instance creation' }
MbDVelRadIeqcJeqc class >> withFrmI: afrmI frmJ: afrmJ [ 
	^(afrmI isMemberOf: MbDEndFrameqc)
		& (afrmJ isMemberOf: MbDEndFrameqc)
		ifTrue: [self new withFrmI: afrmI frmJ: afrmJ]
		ifFalse: [nil]
]

{ #category : 'calc' }
MbDVelRadIeqcJeqc >> calcPostDynCorrectorIteration [
	| prIeJeOpEJT pvIeJeOpEJT prIeJepXJ prIeJepEJ uIeJeOT prIeJeOpEJ |
	super calcPostDynCorrectorIteration.
	rIeJe = 0.0 ifTrue: [^self].
	prIeJeOpEJ := frmJ prOeOpE.
	prIeJeOpEJT := prIeJeOpEJ transpose.
	pvIeJeOpEJT := frmJ pvOeOpE transpose.
	uIeJeOT := uIeJeO transpose.
	prIeJepXJ := uIeJeOT.
	prIeJepEJ := uIeJeOT timesFullMatrix: prIeJeOpEJ.
	1 to: 3 do: [:i | pvIeJepXJ at: i put: (vIeJeO at: i)
				- (vIeJe * (prIeJepXJ at: i)) / rIeJe].
	1 to: 4 do: [:i | pvIeJepEJ at: i put: ((pvIeJeOpEJT at: i)
				dot: rIeJeO)
				+ ((prIeJeOpEJT at: i)
						dot: vIeJeO) - (vIeJe * (prIeJepEJ at: i)) / rIeJe].
	pvIeJepXdotJ := prIeJepXJ.
	pvIeJepEdotJ := prIeJepEJ
]

{ #category : 'initialize-release' }
MbDVelRadIeqcJeqc >> initialize [
	super initialize.
	pvIeJepXJ := StMFullRow new: 3.
	pvIeJepEJ := StMFullRow new: 4.
	pvIeJepXdotJ := StMFullRow new: 3.
	pvIeJepEdotJ := StMFullRow new: 4
]

{ #category : 'accessing' }
MbDVelRadIeqcJeqc >> pvaluepEJ [
	^pvIeJepEJ
]

{ #category : 'accessing' }
MbDVelRadIeqcJeqc >> pvaluepEdotJ [
	^pvIeJepEdotJ
]

{ #category : 'accessing' }
MbDVelRadIeqcJeqc >> pvaluepXJ [
	^pvIeJepXJ
]

{ #category : 'accessing' }
MbDVelRadIeqcJeqc >> pvaluepXdotJ [
	^pvIeJepXdotJ
]
